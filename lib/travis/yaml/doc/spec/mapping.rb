# frozen_string_literal: true
require 'travis/yaml/doc/spec/node'
require 'travis/yaml/helper/merge'

module Travis
  module Yaml
    module Doc
      module Spec
        class Mapping < Node
          register :mapping

          attr_reader :types

          def initialize(parent, spec)
            super(parent, { type: :mapping }.merge(Helper::Common.except(spec, :types)))
            @types = types_for(spec[:types])
          end

          def known_key?(key)
            self.key == key || alias?(key)
          end

          def required?
            types.any?(&:required?)
          end
          memoize :required?

          def alias?(key)
            alias_names.include?(key)
          end

          def alias_names
            aliases.values.flatten
          end
          memoize :aliases

          def aliases
            aliases = types.map { |type| [type.key, type.alias_names] }
            aliases = aliases.select { |key, aliases| !aliases.empty? }
            aliases.to_h
          end
          memoize :aliases

          def required_keys
            types.select(&:required?).map(&:key).flatten.compact.uniq
          end
          memoize :required_keys

          def down_keys
            keys = types.map { |type| down_keys_for(type) }.flatten.compact.uniq
            keys.inject({}) { |all, keys| Helper::Merge.apply(all, keys) }
          end
          memoize :down_keys

          def all_keys
            types.map { |type| type.all_keys }
          end
          memoize :all_keys

          private

            def types_for(spec)
              Array(spec).map do |type|
                Node[type[:type]].new(self, type.merge(key: key))
              end
            end

            def down_keys_for(spec)
              case spec.type
              when :map then spec.known_keys.inject({}) { |keys, key| (keys[key] ||= []) << self.key; keys }
              when :seq then spec.types.map { |type| down_keys_for(type) }
              else []
              end
            end
        end
      end
    end
  end
end
