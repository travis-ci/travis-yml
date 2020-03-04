require 'travis/yml/configs/filter/jobs'
require 'travis/yml/configs/filter/notifications'

module Travis
  module Yml
    module Configs
      class Filter
        FILTERS = %i(notifications)

        attr_reader :config, :jobs, :data, :msgs

        def initialize(config, jobs, data)
          @config = config
          @jobs = jobs
          @data = data
          @msgs = []
        end

        def apply
          @config, @jobs = filters.inject([config, jobs]) do |(config, jobs), filter|
            filter = filter.new(config, jobs, data, msgs).tap(&:apply)
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
