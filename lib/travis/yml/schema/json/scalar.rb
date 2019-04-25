# frozen_string_literal: true
require 'travis/yml/schema/json/node'

module Travis
  module Yml
    module Schema
      module Json
        class Scalar < Node
          register :scalar

          TYPES = {
            bool: :boolean,
            num:  :number,
            str:  :string,
            enum: :string,
          }

          def type
            TYPES[node.type] || raise("Unknown type: #{node.type}")
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

          def opts
            opts = super
            compact(except(opts.merge(pattern: opts[:format]), :format))
          end
        end

        # can we export these and remove them from the hardcoded schema defintion?

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
