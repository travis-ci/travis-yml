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

            description <<~str
              The key `env` defines env vars that will be defined in the build
              environment.

              Env vars can be specified as global or matrix vars. Global vars
              will be defined on every job in the build's job matrix. Matrix
              vars will expand the matrix, i.e. create one additional job per
              entry.

              Env vars can be given either as strings or maps. If given as a
              string they can contain multiple key/value pairs.
            str

            see 'Environment Variables': 'https://docs.travis-ci.com/user/environment-variables/',
                'Build Matrix': 'https://docs.travis-ci.com/user/build-matrix/'

            type Class.new(Type::Map) {
              def define
                normal
                prefix :matrix

                map :global, to: :env_vars, summary: 'Global environment variables to be defined on all jobs'
                matrix :matrix, to: :env_vars, summary: 'Environment variables that expand the build matrix (creating one job per entry)'
              end
            }

            type :env_vars

            export
          end
        end

        class EnvVars < Type::Any
          register :env_vars

          def define
            summary 'Environment variables to set up'

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
