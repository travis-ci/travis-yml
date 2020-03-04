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

            def filter(key, config)
              config = case config
              when Array
                config.map { |config| filter(key, config) }
              when Hash
                config.map { |key, config| [key, filter(key, config)] }.to_h if accept?(key, config[:if])
              else
                config
              end
              config = compact(config)
              config if present?(config)
            end

            def accept?(key, cond)
              return true if Condition.new(cond, config, data).accept?
              msgs << msg(key, cond)
              false
            end

            def msg(key, cond)
              {
                type:  'config',
                level: :info,
                key:   :"notifications.#{key}",
                code:  :condition,
                args:  { target: key, condition: cond }
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
