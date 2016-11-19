module Travis
  module Yaml
    module Spec
      module Type
        class Lang < Node
          include Registry

          def name(name = nil, opts = {})
            return @name unless name
            @name = name.to_s
            opts[:alias] = Array(opts[:alias]).map(&:to_s) if opts[:alias]
            parent.value(name, opts)
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
            root.matrix(key, opts)
          end

          def map(key, opts = {})
            opts = opts.merge(only: { language: [name] })
            root.map(key, opts)
          end

          def value
            parent.values.detect { |value| value[:value] == name }
          end
        end
      end
    end
  end
end
