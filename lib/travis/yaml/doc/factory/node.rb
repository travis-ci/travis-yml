require 'travis/yaml/doc/factory/seq'
require 'travis/yaml/doc/factory/map'
require 'travis/yaml/doc/factory/types'
require 'travis/yaml/doc/normalize/cache'
require 'travis/yaml/doc/normalize/enabled'
require 'travis/yaml/doc/normalize/inherit'
require 'travis/yaml/doc/normalize/prefix'
require 'travis/yaml/doc/normalize/required'
require 'travis/yaml/doc/normalize/secure'
require 'travis/yaml/doc/normalize/symbolize'
require 'travis/yaml/doc/normalize/vars'
require 'travis/yaml/doc/type/fixed'
require 'travis/yaml/doc/type/map'
require 'travis/yaml/doc/type/scalar'
require 'travis/yaml/doc/type/seq'
require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Doc
      module Factory
        class Node < Struct.new(:spec, :parent, :key, :value)
          include Helper::Common

          OPTS = %i(known given strict only except required defaults values alias
            downcase cast format edge flagged alert types conform)

          INHERIT = %i(known alert cast required format)

          NORMALIZERS = %i(symbolize secure prefix)

          def build
            normalize
            node = type.new(parent, key, value, only(spec, *OPTS))
            add_children(node) if add_children?(node)
            map_children(node) if map_children?(node)
            node
          end


          private

            def normalize
              self.value = normalizers.inject(value) do |value, opts|
                Normalize::Normalizer[opts[:name]].new(parent, opts, key, value).apply
              end
            end

            def add_children?(node)
              node.is_a?(Type::Seq)
            end

            def add_children(node)
              Seq.new(spec, value, node).add_children
            end

            def map_children?(node)
              node.is_a?(Type::Map) && value.is_a?(Hash)
            end

            def map_children(node)
              Map.new(spec, value, node).map_children
            end

            def normalizers
              normalizers = NORMALIZERS.map { |name| spec.merge(name: name) }
              normalizers.insert(2, *Array(spec[:normalize]))
            end

            def type
              @type ||= Type::Node[spec[:type]]
            end
        end
      end
    end
  end
end
