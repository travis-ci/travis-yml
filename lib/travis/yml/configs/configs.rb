require 'travis/yml/helper/metrics'
require 'travis/yml/helper/msgs'
require 'travis/yml/helper/obj'
require 'travis/yml/configs/allow_failures'
require 'travis/yml/configs/model/repos'
require 'travis/yml/configs/reorder'
require 'travis/yml/configs/stages'
require 'travis/yml/configs/config/api'
require 'travis/yml/configs/config/file'
require 'travis/yml/configs/ctx'

module Travis
  module Yml
    module Configs
      class Configs < Struct.new(:repo, :ref, :raw, :mode, :data, :opts)
        include Enumerable, Helper::Metrics, Helper::Obj, Memoize

        attr_reader :configs, :config, :stages, :jobs

        # - some data, such as env vars need to be added from the config to
        #   data before processing conditions
        # - move notification filtering to Hub (Yml seems the wrong place)
        # - api does not seem to have github app pem files set up everywhere

        def load
          fetch
          merge
          reencrypt
          expand_matrix
          expand_stages
          allow_failures
          reorder
        end

        def msgs
          @msgs ||= Msgs.new
        end

        def each(&block)
          configs.each(&block)
        end

        def to_a
          configs
        end

        def to_h
          {
            raw_configs: configs.map(&:to_h),
            config: config,
            matrix: jobs,
            stages: stages,
            messages: msgs.messages,
            full_messages: msgs.full_messages
          }
        end

        def to_s
          map(&:to_s).join(', ')
        end

        private

          def fetch
            fetch = ctx.fetch
            fetch.load(raw ? api : travis_yml)
            @configs = fetch.configs.reject(&:empty?)
            msgs.concat(fetch.msgs)
          end
          time :fetch

          def merge
            doc = Yml.load(configs.map(&:part))
            @config = except(doc.serialize, :import)
            msgs.concat(doc.msgs)
          end
          time :merge

          def reencrypt
            keys = configs.select(&:reencrypt?).map(&:repo).uniq.map(&:key)
            @config = repo.reencrypt(config, keys) if keys.any?
          end
          time :reencrypt

          def expand_matrix
            @jobs = Yml.matrix(config: config, data: data).rows
          end
          time :expand_matrix

          def expand_stages
            @stages, @jobs = Stages.new(config[:stages], jobs).apply
          end
          time :expand_stages

          def allow_failures
            @jobs = AllowFailures.new(config.dig(:jobs, :allow_failures), jobs, data).apply
          end
          time :allow_failures

          def reorder
            @jobs = Reorder.new(stages, jobs).apply
          end
          time :reorder

          def travis_yml
            Config.travis_yml(ctx, nil, repo.slug, ref, mode)
          end

          def api
            Config::Api.new(ctx, repo.slug, ref, raw, mode)
          end

          def repo
            repo = Model::Repo.new(super)
            repo.complete? ? ctx.repos[repo.slug] = repo : ctx.repos[repo.slug]
          end
          memoize :repo

          def ctx
            @ctx ||= Ctx.new(data, opts)
          end
      end
    end
  end
end
