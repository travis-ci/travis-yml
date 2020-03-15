require 'travis/yml/helper/condition'

module Travis
  module Yml
    module Configs
      class Filter
        class Notifications < Obj.new(:config, :jobs, :data, :msgs)
          def apply
            @config = compact(config.merge(notifications: notifications))
          end

          private

            def notifications
              filter(nil, config[:notifications])
            end

            def filter(key, config, ix = 0)
              config = case config
              when Array
                config.map.with_index { |config| filter(key, config, ix) }
              when Hash
                config.map { |key, config| [key, filter(key, config)] }.to_h if accept?(key, config[:if], ix)
              else
                config
              end
              config = compact(config)
              config if present?(config)
            end

            def accept?(type, cond, ix)
              return true if Condition.new(cond, config, data).accept?
              msgs << [:info, :"notifications.#{type}", :skip_notification, type: type, number: ix + 1, condition: cond]
              false
            end

            def present?(obj)
              case obj
              when Hash then !obj.empty?
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
