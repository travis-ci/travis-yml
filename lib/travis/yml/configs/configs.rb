require 'travis/yml/helper/metrics'
require 'travis/yml/helper/obj'
require 'travis/yml/configs/allow_failures'
require 'travis/yml/configs/filter'
require 'travis/yml/configs/model/repos'
require 'travis/yml/configs/msgs'
require 'travis/yml/configs/reorder'
require 'travis/yml/configs/stages'
require 'travis/yml/configs/config/api'
require 'travis/yml/configs/config/travis_yml'
require 'travis/yml/configs/ctx'

module Travis
  module Yml
    module Configs
      class Configs < Struct.new(:repo, :ref, :inputs, :data, :opts)
        include Enumerable, Helper::Metrics, Helper::Obj, Memoize

        attr_reader :configs, :config, :stages, :jobs

        # - handle unknown merge modes on /configs
        # - add an acceptance test suite testing all the things through web?
        # - complete specs in configs/allow_failures

        # our Api does not allow retrieving repos by their github_id. that's a
        # problem because we have several repos that have been renamed on
        # GitHub without us knowing because of missing OAuth tokens.

        # setting defaults early vs matrix expansion: if Yml sets defaults on
        # matrix expansion keys, then the matrix expansion logic has no way to
        # figure out if the original config had matrix expansion keys set or
        # not. this resulted in the choice to always reject a single job coming
        # out of the matrix expansion. in order to address that we could either
        # use the msgs produced or mark defaults added to the config in some
        # other way. see https://travisci.slack.com/archives/C5E02QW64/p1582052445034800

        DROP = %i(import merge_mode)

        def load
          fetch
          merge
          reencrypt
          expand_matrix
          expand_stages
          filter
          allow_failures
          reorder_jobs
          unique_jobs
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
            raw_configs: configs.map(&:serialize),
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

        def serialize
          symbolize(config)
        end

        private

          def fetch
            fetch = ctx.fetch
            fetch.load(inputs&.any? ? api : travis_yml)
            @configs = fetch.configs.select { |config| config.api? || !config.empty? }
            msgs.concat(fetch.msgs)
          end
          time :fetch

          def merge
            doc = Yml.apply(Yml::Parts::Merge.new(configs).apply.to_h, opts) if opts[:merge_normalized]
            doc ||= Yml.load(configs.map(&:part), opts)
            @config = except(doc.serialize, *DROP)
            msgs.concat(doc.msgs)
          end

          def filter
            filter = Filter.new(config, jobs, data).tap(&:apply)
            @config = filter.config
            @jobs = filter.jobs
            msgs.concat(filter.msgs)
          end

          def reencrypt
            keys = configs.select(&:reencrypt?).map(&:repo).uniq.map(&:key)
            @config = repo.reencrypt(config, keys) if keys.any?
          end

          def expand_matrix
            matrix = Yml.matrix(config: deep_dup(config), data: data)
            @jobs = matrix.jobs
            msgs.concat(matrix.msgs)
          end
          time :expand_matrix

          def expand_stages
            stages = Stages.new(config, jobs, data)
            @stages, @jobs = stages.apply
            msgs.concat(stages.msgs)
          end

          def allow_failures
            allow_failures = AllowFailures.new(config, jobs, data)
            @jobs = allow_failures.apply
            msgs.concat(allow_failures.msgs)
          end

          def reorder_jobs
            @jobs = Reorder.new(stages, jobs).apply
          end

          def unique_jobs
            @jobs = jobs.uniq
          end

          def api
            input = inputs.shift
            raw, mode = input.values_at(:config, :mode)
            Config::Api.new(ctx, nil, repo.slug, ref, raw, mode, inputs)
          end

          def travis_yml
            Config::TravisYml.new(ctx, nil, repo.slug, ref)
          end

          def repo
            repo = Model::Repo.new(super || {})
            repo.complete? ? ctx.repos[repo.slug] = repo : ctx.repos[repo.slug]
          end
          memoize :repo

          def data
            super || {}
          end

          def ctx
            @ctx ||= Ctx.new(data, opts)
          end
      end
    end
  end
end
