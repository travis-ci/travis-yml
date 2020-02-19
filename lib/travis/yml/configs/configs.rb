# require 'travis/gatekeeper/helpers/metrics'
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
        include Enumerable, Helper::Obj # Helpers::Metrics

        attr_reader :configs, :config, :stages, :jobs

        # + make GET /request/:id?include=request.messages work to spare an API request
        # + allow including the repo's GitHub app token on /repo/:id when authenticated internally.
        # + include settings and private key in Api /repo/:id payload if authenticated internally
        #
        # - move notification filtering to Hub (Yml seems the wrong place)
        # - fix Web /:repo/config
        #
        # + complete reencryption
        # - add metrics

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
            imports.load(raw ? api : travis_yml)
            @configs = imports.configs.reject(&:empty?)
            msgs.concat(imports.msgs)
          end

          def merge
            doc = Yml.load(configs.map(&:part))
            @config = except(doc.serialize, :import)
            msgs.concat(doc.msgs)
          end

          def reencrypt
            keys = configs.select(&:reencrypt?).map(&:repo).uniq.map(&:key)
            @config = repo.reencrypt(config, keys) if keys.any?
          end

          def expand_matrix
            @jobs = Yml.matrix(config: config, data: data).rows
          end

          def expand_stages
            @stages, @jobs = Stages.new(config[:stages], jobs).apply
          end

          def allow_failures
            @jobs = AllowFailures.new(config.dig(:jobs, :allow_failures), jobs, data).apply
          end

          def reorder
            @jobs = Reorder.new(stages, jobs).apply
          end

          def travis_yml
            Config.travis_yml(ctx, nil, repo.slug, ref, mode)
          end

          def api
            Config::Api.new(ctx, repo.slug, ref, raw, mode)
          end

          def imports
            ctx.imports
          end

          def ctx
            @ctx ||= Ctx.new(data, opts).tap do |ctx|
              ctx.repos[repo.slug] = repo if repo.token
            end
          end

          def repo
            @repo ||= if super[:token]
              Model::Repo.new(super)
            else
              Model::Repos.new[super[:slug]]
            end
          end
      end
    end
  end
end
