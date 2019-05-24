# frozen_string_literal: true
require 'forwardable'
require 'registry'
require 'travis/yml/schema/type/dump'
require 'travis/yml/schema/type/opts'

module Travis
  module Yml
    module Schema
      module Type
        class Node < Obj.new(parent: nil)
          extend Forwardable
          include Opts, Registry

          registry :type
          register :node

          opts %i(aliases changes deprecated example flags normal summary unique only except)

          attr_writer :namespace, :opts

          def initialize(parent = nil, opts = {})
            super(parent)
            @opts = {}
            assign(opts)
          end

          def resolve(type)
            type.is_a?(Class) ? type : Node[type]
          end

          def assign(opts)
            opts.each do |key, value|
              set(key, value)
            end
          end

          def set(key, obj)
            opt?(key) ? opt(key, obj) : ivar(key, obj)
          end

          def unset(*keys)
            keys.each do |key|
              opt(key, nil)
              ivar(key, nil)
            end
          end

          def opt(key, obj)
            case obj
            when Hash
              @opts[key] = merge(@opts[key] || {}, obj) unless obj.empty?
            when Array
              @opts[key] = (@opts[key] || []).concat(obj).uniq unless obj.empty?
            else
              obj.nil? ? @opts.delete(key) : @opts[key] = obj
            end
          end

          def ivar(key, obj)
            case obj
            when Hash
              super(key, merge(super(key) || {}, obj)) unless obj.empty?
            when Array
              super(key, (super(key) || []).concat(obj).uniq) unless obj.empty?
            else
              super(key, obj)
            end
          end

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
            types.any? { |type| is_a?(resolve(type)) }
          end

          %i(schema map seq secure scalar str num bool ref).each do |type|
            define_method(:"#{type}?") { is?(type) }
          end

          def type
            self.class.type
          end

          def enum?
            false
          end

          attr_reader :id

          def namespace
            @namespace || :type
          end

          def full_id
            [namespace, id].join('.').to_sym if id
          end
          memoize :full_id

          def opts
            @opts
          end

          def opts?
            @opts&.any?
          end

          def opt?(key)
            self.class.opts.include?(key)
          end

          # attr_accessor :example

          def aliases?
            aliases.any?
          end

          def aliases
            opts[:aliases] ||= []
          end

          def change?(name)
            changes.any? { |change| change[:change] == name }
          end

          def changes
            opts[:changes] ||= []
          end

          def deprecated?
            opts[:deprecated]
          end

          # def examples?
          #   examples.any?
          # end

          def example
            # @examples ||= {}
            opts[:example]
          end

          def expand_key(key)
            expand_keys.push(key).sort!.uniq!
          end

          def expand_keys
            @expand_keys ||= []
          end

          def exports
            @exports ||= []
          end

          def export
            @export = true
          end

          def export?
            !!@export
          end

          def flags?
            flags.any?
          end

          def flags
            @opts[:flags] ||= []
          end

          def internal?
            flags.include?(:internal)
          end

          def key
            @key
          end

          def required?
            !!@required
          end

          def title?
            !!title
          end

          def title
            @title ||= titleize(namespace == :type ? id : "#{namespace}_#{id}")
          end

          def description
            @description
          end

          def normal?
            !!opts[:normal]
          end

          def unique?
            !!opts[:unique]
          end

          def vars?
            @opts&.key?(:vars)
          end

          def ivars
            super.map { |key, value| [key.to_s.sub('@', '').to_sym, value] }.to_h
          end

          # def full_key
          #   root? ? :root : [parent.full_key, id].join('.').split('.').uniq.join('.')
          # end

          def shapeshift(type, opts = {})
            opts = self.opts.merge(ivars).merge(id: id)
            opts = except(opts, :aliases, :expand, :keys, :required) if %i(all any).include?(type) # hmmm.
            Node[type].new(parent, opts)
          end

          def form
            Form.apply(self)
          end

          def definition
            json.definition
          end

          def schema
            json.schema
          end

          def json
            Json::Node[type].new(self)
          end

          def dup
            node = super
            node.opts = node.opts.dup
            node
          end

          def ==(other)
            namespace == other.namespace && id == other.id
          end

          def to_h
            Dump.new(self).to_h
          end

          def dump(opts = {})
            Dump.new(self, opts).dump
          end

          def inspect
            vars = ivars.reject { |name, value| name == :parent || value.nil? }
            vars = vars.map { |name, value| "#{name}=#{value.inspect}" }.join(' ')
            "#<#{self.class.name.sub('Travis::Yml::Schema::Type::', '')}#{" #{vars}" unless vars.empty?}>"
          end
        end
      end
    end
  end
end
