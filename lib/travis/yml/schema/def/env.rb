# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Env < Type::Any
          register :env

          def define
            summary 'Environment variables to set up'

            type Class.new(Type::Map) {
              def define
                normal
                prefix :matrix

                map :global, to: :env_vars, summary: 'Global environment variables to be defined on all jobs'
                map :matrix, to: :env_vars, summary: 'Environment variables that expand the build matrix (i.e. that create one job per entry)'
              end
            }

            type :env_vars

            export
          end
        end

        class EnvVars < Type::Any
          register :env_vars

          def define
            type Class.new(Type::Seq) {
              def define
                normal
                type :env_var
                change :env_vars
              end
            }

            type :env_var

            export
          end
        end

        class EnvVar < Type::Any
          register :env_var

          def define
            type Class.new(Type::Map) {
              def define
                example FOO: 'foo'
                normal
                map :'^(?!global|matrix)', to: :any, type: [:str, :num, :bool, :secure]
                strict false
              end
            }

            # cannot use the standard :secure definition because that also
            # allows a plain string
            type Class.new(Type::Map) {
              register :env_secure

              def define
                normal
                map :secure, to: :str
                max_size 1
              end
            }

            type :str, format: '^[^=]+=[^=]*$', eg: 'FOO=foo'

            export
          end
        end
      end
    end
  end
end
