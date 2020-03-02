require 'travis/yml/configs/filter/notifications'

module Travis
  module Yml
    module Configs
      class Filter
        FILTERS = %i(Notifications)

        attr_reader :config, :data, :msgs

        def initialize(config, data)
          @config = config
          @data = data
          @msgs = []
        end

        def apply
          filters.inject(config) do |config, filter|
            filter.new(config, data, msgs).apply
          end
        end

        def filters
          FILTERS.map { |name| self.class.const_get(name) }
        end
      end
    end
  end
end
