require 'travis/yaml/spec/type/map'
require 'travis/yaml/spec/type/scalar'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Matrix < Type::Map
          register :matrix

          def define
            map :include,        to: :matrix_includes
            map :exclude,        to: :matrix_entries
            map :allow_failures, to: :matrix_entries
            map :fast_finish,    to: :scalar, cast: :bool
          end

          class Includes < Type::Seq
            register :matrix_includes

            def define
              type :matrix_include
            end
          end

          class Include < Type::Map
            register :matrix_include

            def define
              strict false

              map :addons
              map :cache
              map :git
              map :services
              map :source_key,   to: :scalar, cast: :secure

              # TODO can't just include :env
              # map :env

              maps *Root::STAGES, to: :seq
            end
          end

          class Entries < Type::Seq
            register :matrix_entries

            def define
              type :matrix_entry
            end
          end

          class Entry < Type::Map
            register :matrix_entry

            def define
              strict false
              type :matrix_value
            end
          end

          class Value < Type::Scalar
            register :matrix_value

            def define
              validate :matrix
            end
          end
        end
      end
    end
  end
end
