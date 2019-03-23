# frozen_string_literal: true
require 'travis/yaml/doc/helper/lookup'
require 'travis/support/obj'

module Travis
  module Yaml
    module Doc
      module Spec
        def self.detect_type(parent, spec, node)
          Types.new(parent, spec, node).detect
        end

        class Types < Obj.new(:parent, :spec, :node)
          include Helper::Common

          def detect
            type = spec ? match : infer
            type = lookup(type) if type && type.lookup?
            type = type || first || infer
            type
          end

          private

            def lookup(type)
              Helper::Lookup.apply(spec, node, type.keys)
            end

            def match
              spec.types.detect { |type| type.lookup? || type.is?(node.type) }
            end

            def first
              spec.types.detect { |type| !type.lookup? }
            end

            def infer
              case node.type
              when :map then Spec::Map.new(parent, type: :map, key: node.key, strict: false)
              when :seq then Spec::Seq.new(parent, type: :seq, key: node.key, strict: false)
              else           Spec::Scalar.new(parent, type: node.type, key: node.key, strict: false)
              end
            end
        end
      end
    end
  end
end
