# frozen_string_literal: true
require 'travis/yml/schema/dsl/enum'
require 'travis/yml/schema/dsl/lang'
require 'travis/yml/schema/dsl/one'

module Travis
  module Yml
    module Schema
      module Def
        class Languages < Dsl::One
          register :languages

          def define
            normal

            Dsl::Node.registry.values.map do |const|
              add const if const < Lang
            end

            export
          end
        end

        class Lang < Dsl::Lang
          # Collecting these values globally less than ideal, but at the moment
          # i don't see a better way to communicate language names, aliases,
          # and options from the Lang classes to the Language class.
          def self.values(other = nil)
            other ? @values = Helper::Obj.merge(values, other) : @values ||= {}
          end

          def define
            namespace :language
            normal
            strict false
            export
            super
          end
        end

        class Language < Dsl::Enum
          register :language

          def define
            required
            downcase

            default :ruby,          only: { os: [:linux, :windows] }
            default :'objective-c', only: { os: [:osx] }

            value *Lang.values.map { |name, opts| opts.merge(value: name) }

            export
          end
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
