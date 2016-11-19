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
            prefix :include, only: prefix_keys

            map :include,        to: :matrix_entries
            map :exclude,        to: :matrix_entries
            map :allow_failures, to: :matrix_entries, alias: :allowed_failures
            map :fast_finish,    to: :bool, alias: :fast_failure
          end

          def prefix_keys
            Entry.new(root).spec[:map].keys + root.includes[:support].spec[:map].keys
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
              self.include :job, :support

              map :language
              map :os
              map :dist
              map :sudo
              map :env, to: :env_var
              map :compiler, to: :compilers, on: %i(c cpp)
            end
          end
        end
      end
    end
  end
end
