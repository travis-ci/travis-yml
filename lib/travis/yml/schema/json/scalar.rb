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

        class Secure < Scalar
          register :secure

          def to_h
            ref(:secure)
          end
        end
      end
    end
  end
end
