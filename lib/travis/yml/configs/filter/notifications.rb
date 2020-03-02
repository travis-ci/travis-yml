require 'travis/yml/helper/condition'

module Travis
  module Yml
    module Configs
      class Filter
        class Notifications < Struct.new(:config, :data, :msgs)
          def apply
            compact(config.merge(notifications: filter(nil, config[:notifications])))
          end

          private

            def filter(key, config)
              config = case config
              when Array
                config.map { |config| filter(key, config) }
              when Hash
                config.map { |key, config| [key, filter(key, config)] }.to_h if accept?(key, config)
              else
                config
              end
              config = compact(config)
              config if present?(config)
            end

            def accept?(key, config)
              return true unless config.key?(:if)
              return true if Condition.new(config, self.config.merge(data)).accept?
              msgs << msg(key, config)
              false
            end

            def msg(key, config)
              {
                type:  'config',
                level: :info,
                key:   :"notifications.#{key}",
                code:  :condition,
                args:  { target: key, condition: config[:if] }
              }
            end

            def present?(obj)
              case obj
              when Array, Hash then !obj.empty?
              else true
              end
            end

            def compact(obj)
              case obj
              when Array then obj.compact
              when Hash then obj.reject { |_, value| value.nil? }
              else obj
              end
            end
        end
      end
    end
  end
end
