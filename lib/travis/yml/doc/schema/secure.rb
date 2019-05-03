# frozen_string_literal: true
require 'travis/yml/doc/schema/scalar'

module Travis
  module Yml
    module Doc
      module Schema
        class Secure < Any
          # A secure accepts either a secure hash (i.e. a hash with a single
          # key :secure mapping to a string), or a string. A strict secure will
          # also accept a string, but trigger an :alert message. Secures are
          # strict by default, and have to be flagged as not strict in the
          # schema definition.

          def self.opts
            @opts ||= super + %i(max_size strict)
          end

          def matches?(value)
            value.secure? || value.str?
          end

          def type
            :secure
          end

          def is?(type)
            super || type == :str
          end

          def secure?
            true
          end

          def strict?
            !opts[:strict].is_a?(FalseClass)
          end

          def vars?
            false # hmm.
          end

          def all_keys
            []
          end
        end
      end
    end
  end
end
