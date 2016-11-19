module Travis
  module Yaml
    module Spec
      module Type
        class Lang < Map
          include Registry

          def language
            parent.parent
          end

          def name(name = nil, opts = {})
            return @name unless name
            @name = name.to_s
            language.value(name, opts)
          end

          def only(opts)
            value.update(only: opts)
          end

          def except(opts)
            value.update(except: opts)
          end

          def matrix(key, opts = {})
            opts = opts.merge(only: { language: [name] })
            opts[:to] ||= :seq
            parent.matrix(key, opts)
          end

          def map(key, opts = {})
            opts = opts.merge(only: { language: [name] })
            parent.map(key, opts)
          end

          def value
            lang.values.detect { |value| value[:value] == name }
          end
        end
      end
    end
  end
end
