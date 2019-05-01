# frozen_string_literal: true
require 'travis/yml/schema/type/scalar'
require 'travis/yml/schema/type/seq'

module Travis
  module Yml
    module Schema
      module Type
        class Secure < Scalar
          register :secure

          def self.type
            registry_key
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

          def secure?
            true
          end
        end

        class Secures < Seq
          register :secures

          def self.type
            registry_key
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
