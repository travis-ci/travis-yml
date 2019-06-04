# frozen_string_literal: true
require 'travis/yml/docs/examples/node'

module Travis
  module Yml
    module Docs
      module Examples
        class Scalar < Node
          def examples
            [example]
          end

          def example
            self.class.example
          end

          def enum?
            node.opts.key?(:enum)
          end

          def enum
            node.opts[:enum] || []
          end
        end

        class Str < Scalar
          register :str

          def examples
            return Array(node.example) if node.example
            enum? ? enum[0, 2] : Array(example)
          end

          def example
            return Array(node.example).first if node.example
            opts[:example] or enum? ? enum.first : 'string'
          end
        end

        class Num < Scalar
          register :num

          def example
            node.example ? Array(node.example).first : 1
          end
        end

        class Bool < Scalar
          register :bool

          def self.example
            true
          end
        end

        class Secure < Node
          register :secure

          def examples
            [example]
          end

          def example
            { secure: 'encrypted string' }
            # 'unencrypted string'
          end
        end
      end
    end
  end
end
