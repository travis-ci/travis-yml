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
            add Class.new(Dsl::Map) {
              def define
                normal
                prefix :matrix

                map :global, to: :env_vars
                map :matrix, to: :env_vars
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
            # cannot use the standard :secure definition because that also
            # allows a plain string
            add Class.new(Dsl::Map) {
              def define
                normal
                map :secure, to: :str
                max_size 1
              end
            }

            add Class.new(Dsl::Map) {
              def define
                normal
                map :'^(?!global|matrix)', to: :str
                strict false
                max_size 1 # TODO this isn't true
              end
            }

            add :str, format: '^[^=]+=[^=]+$'

            export
          end
        end
      end
    end
  end
end

