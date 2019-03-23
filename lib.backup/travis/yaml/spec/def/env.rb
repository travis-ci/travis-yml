# frozen_string_literal: true
require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Env < Type::Map
          register :env

          def define
            strict false
            prefix :matrix

            map :global, to: :env_vars
            map :matrix, to: :env_vars
          end
        end

        class EnvVars < Type::Seq
          register :env_vars

          def define
            strict false
            change :env
          end
        end

        class EnvVar < Type::Scalar
          register :env_var

          def define
            strict false
            change :env
          end
        end
      end
    end
  end
end
