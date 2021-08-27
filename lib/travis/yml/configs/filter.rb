require 'travis/yml/configs/filter/jobs'
require 'travis/yml/configs/filter/notifications'
require 'travis/yml/configs/filter/env'

module Travis
  module Yml
    module Configs
      class Filter
        FILTERS = %i(notifications env)

        attr_reader :config, :jobs, :data, :repo, :msgs

        def initialize(config, jobs, data, repo)
          @config = config
          @jobs = jobs
          @data = data
          @repo = repo
          @msgs = []
        end

        def apply
          @config, @jobs = filters.inject([config, jobs]) do |(config, jobs), filter|
            filter = filter.new(config, jobs, data, repo, msgs).tap(&:apply)
            [filter.config, filter.jobs]
          end
          nil
        end

        def filters
          FILTERS.map { |name| self.class.const_get(name.capitalize) }
        end
      end
    end
  end
end
