require 'travis/yaml/doc/spec/node'

module Travis
  module Yaml
    module Doc
      module Spec
        class Seq < Node
          register :seq

          attr_reader :types

          def initialize(parent, spec)
            super(parent, Helper::Common.except(spec, :types))
            @types = types_for(spec[:types])
          end

          def type
            :seq
          end

          def required_keys
            types.map(&:required_keys).flatten.compact.uniq
          end
          memoize :required_keys

          def down_keys
            {}
          end

          def all_keys
            types.map { |type| type.all_keys }.flatten.compact.uniq
          end
          memoize :all_keys

          private

            def types_for(spec)
              Array(spec).map { |type| Node[type[:type]].new(self, type) }
            end
        end
      end
    end
  end
end
