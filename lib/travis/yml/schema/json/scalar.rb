# frozen_string_literal: true
require 'travis/yml/schema/json/node'

module Travis
  module Yml
    module Schema
      module Json
        class Scalar < Node
          register :scalar

          def type
            case node
            when Type::Bool then :boolean
            when Type::Num  then :number
            when Type::Str  then :string
            else raise("Unknown type: #{node.class}")
            end
          end

          def to_h
            { type: type }.merge(opts)
          end
        end

        class Bool < Scalar
          register :bool
        end

        class Num < Scalar
          register :num
        end

        class Str < Scalar
          register :str

          REMAP = {
            format: :pattern
          }

          def remap(opts)
            opts.map { |key, value| [REMAP[key] || key, value] }.to_h
          end
        end

        # can we get rid of these hardcoded schema definitions?

        class Strs < Node
          register :strs

          def to_h
            {
              '$id': :strs,
              anyOf: [
                {
                  type: :array,
                  minItems: 1,
                  items: {
                    anyOf: [
                      { type: :string }
                    ]
                  },
                  normal: true
                },
                {
                  type: :string
                }
              ]
            }
          end

          def export?
            true
          end
        end

        class Secure < Node
          register :secure

          def to_h
            {
              '$id': :secure,
              anyOf: [
                {
                  type: :object,
                  properties: {
                    secure: {
                      type: :string
                    }
                  },
                  additionalProperties: false,
                  maxProperties: 1,
                  normal: true
                },
                {
                  type: :string,
                  normal: true
                }
              ]
            }
          end

          def export?
            true
          end
        end

        class Secures < Node
          register :secures

          def to_h
            {
              '$id': :secures,
              anyOf: [
                {
                  type: :array,
                  items: { '$ref': '#/definitions/type/secure' },
                  normal: true
                },
                {
                  '$ref': '#/definitions/type/secure'
                }
              ]
            }
          end

          def export?
            true
          end
        end
      end
    end
  end
end
