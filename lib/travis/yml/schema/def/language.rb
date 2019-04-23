# frozen_string_literal: true
require 'travis/yml/schema/dsl/enum'
require 'travis/yml/schema/dsl/lang'
require 'travis/yml/schema/dsl/one'

module Travis
  module Yml
    module Schema
      module Def
        class Languages < Dsl::Any
          register :languages

          def define
            normal
            add *Lang.registry.values
            export
          end
        end

        class Lang < Dsl::Lang
          registry :languages

          def before_define
            namespace :language
            normal
            strict false
            super
          end

          def after_define
            export
          end
        end

        class Language < Dsl::Enum
          register :language

          def define
            downcase

            default :ruby,          only: { os: [:linux, :windows] }
            default :'objective-c', only: { os: [:osx] }

            # enum values will be registered from Dsl::Lang
          end
        end
      end
    end
  end
end

require 'travis/yml/schema/def/lang/android'
require 'travis/yml/schema/def/lang/c'
require 'travis/yml/schema/def/lang/clojure'
require 'travis/yml/schema/def/lang/cpp'
require 'travis/yml/schema/def/lang/crystal'
require 'travis/yml/schema/def/lang/csharp'
require 'travis/yml/schema/def/lang/d'
require 'travis/yml/schema/def/lang/dart'
require 'travis/yml/schema/def/lang/elixir'
require 'travis/yml/schema/def/lang/elm'
require 'travis/yml/schema/def/lang/erlang'
require 'travis/yml/schema/def/lang/go'
require 'travis/yml/schema/def/lang/groovy'
require 'travis/yml/schema/def/lang/haskell'
require 'travis/yml/schema/def/lang/haxe'
require 'travis/yml/schema/def/lang/java'
require 'travis/yml/schema/def/lang/julia'
require 'travis/yml/schema/def/lang/nix'
require 'travis/yml/schema/def/lang/node_js'
require 'travis/yml/schema/def/lang/objective_c'
require 'travis/yml/schema/def/lang/perl'
require 'travis/yml/schema/def/lang/perl6'
require 'travis/yml/schema/def/lang/php'
require 'travis/yml/schema/def/lang/python'
require 'travis/yml/schema/def/lang/r'
require 'travis/yml/schema/def/lang/ruby'
require 'travis/yml/schema/def/lang/rust'
require 'travis/yml/schema/def/lang/scala'
require 'travis/yml/schema/def/lang/shell'
require 'travis/yml/schema/def/lang/smalltalk'
require 'travis/yml/schema/def/lang/stacks'
