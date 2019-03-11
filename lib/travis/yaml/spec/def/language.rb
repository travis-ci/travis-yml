require 'travis/yaml/spec/def/lang/android'
require 'travis/yaml/spec/def/lang/c'
require 'travis/yaml/spec/def/lang/clojure'
require 'travis/yaml/spec/def/lang/cpp'
require 'travis/yaml/spec/def/lang/crystal'
require 'travis/yaml/spec/def/lang/csharp'
require 'travis/yaml/spec/def/lang/d'
require 'travis/yaml/spec/def/lang/dart'
require 'travis/yaml/spec/def/lang/elixir'
require 'travis/yaml/spec/def/lang/elm'
require 'travis/yaml/spec/def/lang/erlang'
require 'travis/yaml/spec/def/lang/go'
require 'travis/yaml/spec/def/lang/groovy'
require 'travis/yaml/spec/def/lang/hack'
require 'travis/yaml/spec/def/lang/haskell'
require 'travis/yaml/spec/def/lang/haxe'
require 'travis/yaml/spec/def/lang/java'
require 'travis/yaml/spec/def/lang/julia'
require 'travis/yaml/spec/def/lang/nix'
require 'travis/yaml/spec/def/lang/node_js'
require 'travis/yaml/spec/def/lang/objective_c'
require 'travis/yaml/spec/def/lang/perl'
require 'travis/yaml/spec/def/lang/perl6'
require 'travis/yaml/spec/def/lang/php'
require 'travis/yaml/spec/def/lang/python'
require 'travis/yaml/spec/def/lang/r'
require 'travis/yaml/spec/def/lang/ruby'
require 'travis/yaml/spec/def/lang/rust'
require 'travis/yaml/spec/def/lang/scala'
require 'travis/yaml/spec/def/lang/shell'
require 'travis/yaml/spec/def/lang/smalltalk'
require 'travis/yaml/spec/def/lang/worker_stacks'
require 'travis/yaml/spec/type/fixed'

module Travis
  module Yaml
    module Spec
      module Def
        class Language < Type::Fixed
          register :language

          def define
            default :ruby
            downcase

            root.includes[:support] = Support.new(self)
          end
        end
      end
    end
  end
end
