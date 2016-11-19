require 'travis/yaml/spec/type/fixed'
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Compilers < Type::Seq
          register :compilers

          def define
            type :compiler
            default :gcc
          end
        end

        class Compiler < Type::Fixed
          register :compiler

          def define
            downcase
            value :gcc,   alias: :'g++'
            value :clang, alias: :'clang++'
          end
        end
      end
    end
  end
end
