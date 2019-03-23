# frozen_string_literal: true
require 'travis/yaml/doc/spec/value'
require 'travis/support/obj'

module Travis
  module Yaml
    module Doc
      module Spec
        class Node < Obj.new(:parent, :spec)
          include Helper::Common, Helper::Memoize, Registry

          def root
            root? ? self : parent.root
          end

          def root?
            parent.nil?
          end

          def key
            spec[:key]
          end

          def name
            spec[:name]
          end

          def is?(type)
            self.type == type
          end

          def lookup?
            is_a?(Lookup)
          end
          memoize :lookup?

          def scalar?
            is_a?(Scalar)
          end
          memoize :scalar?

          def fixed?
            is_a?(Fixed)
          end
          memoize :fixed?

          def seq?
            is_a?(Seq)
          end
          memoize :seq?

          def map?
            is_a?(Map)
          end
          memoize :map?

          def mapping?
            is_a?(Mapping)
          end
          memoize :mapping?

          def changes
            Array(spec[:change])
          end
          memoize :changes

          def validators
            Array(spec[:validate])
          end
          memoize :validators

          def cast
            spec[:cast] || :str
          end
          memoize :cast

          def secure?
            !!spec[:secure]
          end
          memoize :secure?

          def downcase?
            !!spec[:downcase]
          end
          memoize :downcase?

          def strict?
            spec.key?(:strict) ? !!spec[:strict] : true
          end
          memoize :strict?

          def prefix?
            !prefix.empty?
          end
          memoize :prefix?

          def prefix
            spec[:prefix] || {}
          end
          memoize :prefix

          def version?
            !!spec[:version]
          end
          memoize :version?

          def expand?
            !!spec[:expand]
          end
          memoize :expand?

          def include
            spec[:include] || []
          end
          memoize :include

          def includes
            spec[:includes] || {}
          end
          memoize :includes

          def version
            spec[:version]
          end

          def known_key?(key)
            key && known_keys.include?(key.to_sym)
          end

          def known_keys
            keys + aliased.keys
          end
          memoize :known_keys

          def misplaced_key?(key)
            key && misplaced_keys.include?(key.to_sym)
          end

          def misplaced_keys
            Yaml.keys - known_keys
          end
          memoize :misplaced_keys

          def alias?(key)
            key && aliased.key?(key.to_sym)
          end

          def aliases
            spec[:alias] ? { key => alias_names.map(&:to_sym) } : {}
          end
          memoize :aliases

          def alias_names
            Array(spec[:alias]).map(&:to_sym)
          end
          memoize :alias_names

          def aliased
            swap(aliases).map { |key, value| [key, value.first] }.to_h
          end
          memoize :aliased

          def default?
            !defaults.empty?
          end
          memoize :default?

          def defaults
            spec[:defaults] || []
          end
          memoize :defaults

          def except
            spec[:except] || {}
          end
          memoize :except

          def only
            spec[:only] || {}
          end
          memoize :only

          def format
            spec[:format]
          end
          memoize :format

          def required?
            !!spec[:required]
          end
          memoize :required?

          def edge?
            !!spec[:edge]
          end
          memoize :edge?

          def flagged?
            spec[:flagged]
          end
          memoize :flagged?

          def deprecated?
            !!spec[:deprecated]
          end
          memoize :deprecated?

          def deprecated
            spec[:deprecated]
          end
          memoize :deprecated

          def required_keys
            []
          end

          def full_key
            ancestors.uniq.join('.').sub('root.', '').to_sym
          end
          memoize :full_key

          def all_keys
            [key]
          end
          memoize :all_keys

          def ancestors
            keys = parent.respond_to?(:ancestors) ? parent.ancestors : []
            keys + [key]
          end
          memoize :ancestors

          def inspect
            "#<#{self.class.name} key=#{key.inspect} spec=#{spec.inspect}>"
          end
        end
      end
    end
  end
end
