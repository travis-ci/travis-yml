# frozen_string_literal: true
require 'travis/yml/schema/dsl/str'
require 'travis/yml/schema/dsl/lang'
require 'travis/yml/schema/dsl/one'

module Travis
  module Yml
    module Schema
      module Def
        # Mapped on root on the :language key. The Language values (known
        # names) are populated by the Lang::* instances (language
        # implementations), rather than here (see Dsl::Lang#before_define).
        class Language < Dsl::Str
          register :language

          def self.instances
            @instances ||= []
          end

          def initialize(*)
            self.class.instances << self
            super
          end

          def define
            summary 'Language support'
            downcase
            default :ruby,          only: { os: [:linux, :windows] }
            default :'objective-c', only: { os: [:osx] }
            export
          end
        end

        # Common subclass of all concrete Lang::* language implementations.
        # Enforces common behaviour, so language maintainers do not have to pay
        # attention to these.
        class Lang < Dsl::Lang
          registry :language

          class << self
            def register(key)
              const = Class.new(Def::Support)
              const.register :"#{key}_support"
              const_set(:Support, const)
              super
            end

            def support
              const_get(:Support)
            end
          end

          def before_define
            normal
            strict false
            export
          end
        end

        # Common subclass of all Lang::*::Support classes that are created for
        # concrete Lang::* implementations automatically. See the collection
        # Supports below, as well as Dsl::Lang#support.
        class Support < Dsl::Support
          registry :support

          def before_define
            normal
            strict false
            export
          end
        end

        # Collection of all concrete Lang::* language implementations. This
        # will be included to the root node, so language specific keys are
        # mapped as matrix keys (:node_js, :rvm, etc.) or normal keys
        # (:bundler_args, :go_import_path, etc.).
        class Languages < Dsl::Any
          register :languages

          def define
            normal
            add *Lang.registry.values
            export
          end
        end

        # Collection of Lang::Support instances that are automatically created
        # for each Lang::* instance. These are being included to matrix entry
        # (matrix.include, matrix.exclude, matrix.allow_failures) nodes and
        # deploy conditions. Language matrix expand keys need to be normal keys
        # on these nodes, which is why a separate construct exists for them.
        class Supports < Dsl::Any
          register :support

          def define
            normal
            add *Lang.registry.values.map(&:support)
            export
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
