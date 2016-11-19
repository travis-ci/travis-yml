require 'travis/yaml/spec/type/node'

module Travis
  module Yaml
    module Spec
      module Type
        class Seq < Node
          register :seq

          def type(*types)
            opts = types.last.is_a?(Hash) ? types.pop : {}
            types.any? ? @types = resolve(types, opts) : @types
          end

          def types
            @types ||= [Scalar.new]
          end

          def default(value, opts = {})
            defaults << { value: value.to_s }.merge(opts)
          end

          def defaults
            opts[:defaults] ||= []
          end

          def prefix(prefix, opts = {})
            self.opts[:prefix] = { key: prefix }.merge(opts)
          end

          def resolve(types, opts)
            types.map do |type|
              next type.new(self) if type.is_a?(Class)
              const = Node[type]
              const.new(self, opts)
            end
          end

          def spec
            spec = {}
            spec = spec.merge(name: registry_key) unless registry_key == :seq
            spec = spec.merge(type: :seq)
            spec = spec.merge(opts)
            spec = spec.merge(types: Array(types).map(&:spec))
            spec
          end
        end
      end
    end
  end
end
