# frozen_string_literal: true
require 'travis/yml/schema/dsl/any'
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        class Env < Dsl::Any
          register :env

          def define
            summary 'Environment variables to set up'

            add Class.new(Dsl::Map) {
              def define
                normal
                prefix :matrix

                map :global, to: :env_vars #, summary: 'Global environment variables to be defined on all jobs'
                map :matrix, to: :env_vars #, summary: 'Environment variables that expand the build matrix (i.e. that create one job per entry)'
              end
            }

            add EnvVars

            # change :env_vars

            export
          end
        end

        class EnvVars < Dsl::Any
          register :env_vars

          def define
            add Class.new(Dsl::Seq) {
              def define
                normal
                type :env_var
                change :env_vars
              end
            }

            add EnvVar

            export
          end
        end

        class EnvVar < Dsl::Any
          register :env_var

          def define
            add Class.new(Dsl::Map) {
              def define
                normal
                map :'^(?!global|matrix)', to: :any, type: [:str, :num, :bool]
                strict false
              end
            }

            # cannot use the standard :secure definition because that also
            # allows a plain string
            add Class.new(Dsl::Map) {
              register :env_secure

              def define
                normal
                map :secure, to: :str
                max_size 1
              end
            }

            add :str, format: '^[^=]+=[^=]*$'

            export
          end
        end
      end
    end
  end
end

