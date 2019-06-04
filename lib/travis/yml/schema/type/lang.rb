require 'travis/yml/schema/type/group'
require 'travis/yml/schema/type/map'
require 'travis/yml/schema/type/scalar'

module Travis
  module Yml
    module Schema
      module Type
        class Language < Str
        end

        # Common subclass of all concrete Lang::* language implementations.
        # Enforces common behaviour, so language maintainers do not have to pay
        # attention to these.
        class Lang < Map
          registry :language

          def self.support
            const_get(:Support)
          end

          def before_define
            const = Class.new(Support)
            const.register :"#{registry_key}_support"
            self.class.const_set(:Support, const)
            build(const) # forces an export
            language.value(registry_key)
          end

          def after_define
            normal
            strict false
            export
          end

          def aliases(*aliases)
            language.value(registry_key, aliases: aliases)
          end

          def deprecated(obj)
            language.value(registry_key, deprecated: obj)
          end

          def internal
            language.value(registry_key, internal: true)
          end

          def map(key, opts = {})
            opts = opts.merge(only: { language: registry_key })
            support.map(key, except(opts, :expand))
            opts[:to] ||= :seq
            super
          end

          def language
            Node.exports[:'type/language']
          end

          def support
            Node.exports[:"support/#{registry_key}_support"]
          end
        end

        # Collection of all concrete Lang::* language implementations. This
        # will be included to the root node, so language specific keys are
        # mapped as matrix keys (:node_js, :rvm, etc.) or normal keys
        # (:bundler_args, :go_import_path, etc.).
        class Languages < Any
          register :languages

          def define
            normal
            types *Lang.registry.values
            export
          end

          def id
            registry_key
          end
        end

        # Common subclass of all Lang::*::Support classes that are created for
        # concrete Lang::* implementations automatically. See the collection
        # Supports below, as well as Type::Lang#support.
        class Support < Map
          registry :support

          def define
            normal
            strict false
            export
          end

          # Matrix keys need to be mapped as normal keys on Support (which ends
          # up being included in matrix entry and deploy conditions). Therefore
          # we default the type to a :str, rather than a :seq. if a given type
          # is a seq, we pick it's first type. This means that on languages we
          # cannot map to a seq with multiple types.
          def map(key, opts = {})
            opts[:to] = opts[:to] ? singular(opts[:to]) : :str
            super
          end

          def singular(type)
            const = resolve(type)
            const.is?(:seq) ?resolve(const.registry_key.to_s.sub(/s$/, '')) : type
          end

          def resolve(type)
            type.is_a?(Class) ? type : Node.lookup(type)
          end
        end

        # Collection of Lang::Support instances that are automatically created
        # for each Lang::* instance. These are being included to matrix entry
        # (matrix.include, matrix.exclude, matrix.allow_failures) nodes and
        # deploy conditions. Language matrix expand keys need to be normal keys
        # on these nodes, which is why a separate construct exists for them.
        class Supports < Any
          register :support

          def define
            # force languages to be defined first
            resolve(:languages).new

            normal
            types *Lang.registry.values.map(&:support)
            export
          end

          def id
            registry_key
          end
        end
      end
    end
  end
end
