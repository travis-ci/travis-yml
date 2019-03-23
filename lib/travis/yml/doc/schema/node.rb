# frozen_string_literal: true
require 'travis/yml/support/memoize'
require 'registry'

module Travis
  module Yml
    module Doc
      module Schema
        class Node < Obj.new(:opts)
          include Memoize, Registry

          def self.opts
            @opts ||= %i(id type changes deprecated flags normal required except only)
          end

          def initialize(opts)
            validate_opts(opts)
            super
          end

          def matches?(value)
            value && value.is?(type) || value.none?
          end

          def id
            opts[:id]
          end

          def type
            opts[:type]
          end

          def is?(type)
            self.type == type
          end

          %i(bool num str enum seq map mapping schema all one).each do |type|
            define_method(:"#{type}?") { is?(type) }
          end

          def any?(&block)
            raise 'overwrite this method to accept a block' if block
            is?(:any)
          end

          def inherit?
            change?(:inherit)
          end

          def change?(change)
            !!change(change)
          end

          def change(change)
            Array(opts[:changes]).detect { |opt| opt[:change] == change }
          end

          def changes
            opts[:changes]
          end

          def normal?
            !!opts[:normal]
          end

          def scalar?
            false
          end

          def secure?
            false
          end

          # def silence(*keys)
          #   silent.concat(keys).uniq!
          # end

          def silent?(key)
            silent.include?(key) || key.to_s.start_with?('_')
          end

          def silent
            @silent ||= []
          end

          # def full_key
          #   root? ? :root : [parent.full_key, key].join('.').split('.').compact.uniq.join('.')
          # end

          # def name
          #   opts[:name]
          # end

          # def lookup?
          #   is_a?(Lookup)
          # end

          # def changes
          #   Array(opts[:change])
          # end
          # memoize :changes

          # def validators
          #   Array(opts[:validate])
          # end
          # memoize :validators

          # def cast
          #   opts[:cast] || :str
          # end
          # memoize :cast

          def strict?
            false?(opts[:strict]) ? false : true
          end
          memoize :strict?

          def prefix?
            !!prefix
          end

          def prefix
            opts[:prefix]
          end

          # def version?
          #   !!opts[:version]
          # end
          # memoize :version?
          #
          # def version
          #   opts[:version]
          # end

          # def expand?
          #   !!opts[:expand]
          # end
          # memoize :expand?

          # def alias?(key)
          #   key && aliased.key?(key.to_sym)
          # end
          #
          # def aliases
          #   opts[:alias] ? { key => alias_names.map(&:to_sym) } : {}
          # end
          # memoize :aliases
          #
          # def alias_names
          #   Array(opts[:alias]).map(&:to_sym)
          # end
          # memoize :alias_names
          #
          # def aliased
          #   swap(aliases).map { |key, value| [key, value.first] }.to_h
          # end
          # memoize :aliased

          # def except
          #   opts[:except] || {}
          # end
          # memoize :except
          #
          # def only
          #   opts[:only] || {}
          # end
          # memoize :only

          def aliases
            {}
          end

          def required?
            !!opts[:required]
          end

          def edge?
            flags.include?(:edge)
          end

          def flags
            opts[:flags] ||= []
          end

          # def deprecated?
          #   !!opts[:deprecated]
          # end
          # memoize :deprecated?
          #
          # def deprecated
          #   opts[:deprecated]
          # end
          # memoize :deprecated
          #
          # def required_keys
          #   []
          # end

          def support
            { only: {}, except: {} }.merge(only(opts, :only, :except))
          end
          memoize :support

          def all_keys
            []
          end

          def validate_opts(opts)
            keys = opts.keys - self.class.opts
            raise "Unknown opts on #{type}: #{keys}" if keys.any?
          end

          def to_h
            compact(id: id, key: key, type: type, opts: opts)
          end

          def inspect
            type = self.class.name.sub('Travis::Yml::Doc::', '')
            pairs = compact(
              id: id,
              map: (map? && map.keys.any?) ? map.map { |key, obj| [key, obj.class.name.sub('Travis::Yml::Doc::Schema::', '').downcase.to_sym] }.to_h : nil,
              # schemas: respond_to?(:schemas) && schemas ? "[#{schemas.map(&:inspect).join(', ')}]" : nil,
              # schema: respond_to?(:schema) ? schema.inspect : nil,
              opts: opts.any? ? opts : nil
            )
            '#<%s %s>' % [type, pairs.map { |pair| pair.join('=') }.join(' ')]
          end
        end
      end
    end
  end
end
