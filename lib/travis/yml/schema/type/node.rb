# frozen_string_literal: true
require 'forwardable'
require 'registry'
require 'travis/yml/support/memoize'
require 'travis/yml/schema/type/dump'
require 'travis/yml/schema/type/expand'
require 'travis/yml/schema/type/opts'

module Travis
  module Yml
    module Schema
      module Type
        class Node < Obj.new(parent: nil)
          extend Forwardable
          include Memoize, Opts, Registry

          register :node

          opts %i(changes deprecated flags normal only except)

          class << self
            def def?
              name.to_s.include?('Def')
            end

            def exports
              @exports ||= {}
            end

            def resolve(type)
              type.is_a?(Class) ? type : self[type]
            end
          end

          attr_writer :namespace

          def initialize(parent = nil, opts = {})
            super(parent)
            @opts = {}
            assign(opts)
          end

          def assign(opts)
            opts.each do |key, value|
              set(key, value)
            end
          end

          def namespace
            @namespace || :type
          end

          def opts
            # puts nil, caller[0..4] if caller.none? { |line| line.include?('json') }
            @opts
          end

          def opts?
            @opts&.any?
          end

          def set(key, obj)
            if opt?(key)
              opt(key, obj)
            else
              ivar(key, obj)
            end
          end

          def opt?(key)
            self.class.opts.include?(key)
          end

          def opt(key, obj)
            case obj
            when Hash
              @opts[key] = merge(@opts[key] || {}, obj) if obj.any?
            when Array
              @opts[key] = (@opts[key] || []).concat(obj).uniq if obj.any?
            else
              obj.nil? ? @opts.delete(key) : @opts[key] = obj
            end
          end

          def ivar(key, obj)
            case obj
            when Hash
              super(key, merge(super(key) || {}, obj)) if obj.any?
            when Array
              super(key, (super(key) || []).concat(obj).uniq) if obj.any?
            else
              super(key, obj)
            end
          end

          def resolve(type)
            self.class.resolve(type)
          end

          attr_reader :id

          def root
            parent ? parent.root : self
          end

          def root?
            parent.nil?
          end

          def parent(*types)
            return super() if types.empty?
            is?(*types) ? self : parent.parent(*types)
          end

          def is?(*types)
            types.any? { |type| is_a?(type) }
          end

          def schema?
           is_a?(Schema)
          end

          def map?
            is_a?(Map)
          end

          def seq?
            is_a?(Seq)
          end

          def enum?
            is_a?(Enum)
          end

          def secure?
            is_a?(Secure)
          end

          def scalar?
            is_a?(Scalar)
          end

          def str?
            is_a?(Str)
          end

          def num?
            is_a?(Num)
          end

          def bool?
            is_a?(Bool)
          end

          def type
            self.class.type
          end

          def examples?
            examples.any?
          end

          def examples
            @examples ||= []
          end

          def aliases
            @aliases ||= []
          end

          def deprecated?
            opts[:deprecated]
          end

          def expand(key = nil)
            key.nil? ? @expand ||= [] : expand.push(key).sort!.uniq!
          end

          def export
            @export = true
            @title = titleize(id) unless title # hmmmm.
          end

          def export?
            !!@export
          end

          def flags
            @opts[:flags]
          end

          def key
            @key
          end

          def required?
            !!@required
          end

          def strict?
            !false?(opts[:strict])
          end

          def support
            @support ||= {}
          end

          def title?
            !!title
          end

          def title
            @title
          end

          def unique?
            !!@unique
          end

          def vars?
            @opts&.key?(:vars)
          end

          # def full_key
          #   root? ? :root : [parent.full_key, id].join('.').split('.').uniq.join('.')
          # end

          def definitions
            json.definitions
          end

          def schema
            json.schema
          end

          def json
            node = Expand.apply(self)
            Json::Node[node.type].new(node)
          end

          def to_h
            Dump.new(self).to_h
          end

          def dump
            Dump.new(self).dump
          end

          def inspect
            vars = ivars.map { |name, value| "#{name}=#{value.inspect}" unless value.nil? }.compact.join(' ')
            "#<#{self.class.name.sub('Travis::Yml::Schema::Type::', '')}#{" #{vars}" unless vars.empty?}>"
          end
        end
      end
    end
  end
end
