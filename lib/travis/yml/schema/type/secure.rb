# frozen_string_literal: true
require 'travis/yml/schema/type/scalar'
require 'travis/yml/schema/type/seq'

module Travis
  module Yml
    module Schema
      module Type
        class Secure < Scalar
          # anyOf: [
          #   {
          #     type: :object,
          #     properties: {
          #       secure: {
          #         type: :string
          #       }
          #     },
          #     additionalProperties: false,
          #     maxProperties: 1,
          #     normal: true
          #   },
          #   {
          #     type: :string,
          #     normal: true
          #   }
          # ]
          register :secure

          def self.type
            :secure
          end

          def namespace
            :type
          end

          def id
            registry_key
          end

          def export?
            true
          end
        end

        class Secures < Seq
          # anyOf: [
          #   {
          #     type: :array,
          #     items: { '$ref': '#/definitions/secure' },
          #     normal: true
          #   },
          #   {
          #     '$ref': '#/definitions/secure'
          #   }
          # ]
          register :secures

          def self.type
            :secures
          end

          def namespace
            :type
          end

          def id
            registry_key
          end

          def types
            [Secure.new(self)]
          end

          def export?
            true
          end
        end
      end
    end
  end
end
