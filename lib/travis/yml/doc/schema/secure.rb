# frozen_string_literal: true
require 'travis/yml/doc/schema/scalar'

module Travis
  module Yml
    module Doc
      module Schema
        class Secure < Any
          # A secure will by default accept either a secure hash (i.e. a hash
          # with a single key :secure mapping to a string), or a string. A
          # strict secure will not accept a string, but only a secure hash.
          #
          # Secures are not strict by default so we accept various options,
          # e.g. on deploy providers and notifications that can be secure vars
          # or just strings, such as :username or :room. We still want them to
          # map to :secure so we can alert on any secures that accept a string.
          #
          # However, env vars can not accept strings, but only strict secures
          # due to the various formats that the :env key accepts, where we only
          # want to allow strings that match a format that includes an equal
          # sign.

          def self.opts
            @opts ||= super + %i(max_size strict)
          end

          def matches?(value)
            value.secure? || !strict? && value.str?
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
            !!opts[:strict]
          end

          def vars?
            false # hmm.
          end

          def all_keys
            [:secure]
          end
        end
      end
    end
  end
end
