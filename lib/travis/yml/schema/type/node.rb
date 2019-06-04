require 'forwardable'
require 'registry'
require 'travis/yml/schema/type/dump'
require 'travis/yml/schema/type/export'
require 'travis/yml/schema/type/form'
require 'travis/yml/schema/type/opts'

module Travis
  module Yml
    module Schema
      module Type
        class Node < Obj.new(parent: nil, attrs: {})
          extend Forwardable, Helper::Obj
          include Registry, Opts

          registry :type

          opts %i(aliases changes deprecated example flags normal description
            summary title only except)

          class << self
            def build(type, attrs = {})
              caching(resolve(type), attrs) do |type|
                node = type.new(self, only(attrs, :types))
                node = Form.apply(node)
                node = Export.apply(node)
                node.assign(except(attrs, :types))
                node
              end
            end

            def caching(type, attrs)
              if type.cache?(attrs) && node = cache[type.registry_full_key]
                node
              else
                node = yield type
                cache[type.registry_full_key] = node if type.cache?(attrs)
                node
              end
            end

            def cache?(attrs)
              def? && registry_key && attrs.empty?
            end

            def cache
              @cache ||= superclass.respond_to?(:cache) ? superclass.cache : {}
            end

            def exports
              @exports ||= superclass.respond_to?(:exports) ? superclass.exports : {}
            end

            def def?
              name.to_s.include?('Def::')
            end

            def is?(*types)
              types.any? { |type| self < Node[type] }
            end

            def resolve(type)
              type.is_a?(Class) ? type : lookup(type)
            end

            def registry_full_key
              [registry_name, registry_key].join('.').to_sym
            end
          end

          def_delegators :'self.class', :build, :resolve, :def?

          def initialize(parent = nil, attrs = {})
            super(parent, attrs)
            before_define
            define
            after_define
          end

          def before_define
          end

          def define
          end

          def after_define
          end

          def type(*args)
            types(*args) if args.any?
          end

          def is?(*types)
            types.any? { |type| is_a?(Node[type]) }
          end

          def any?
            is?(:any)
          end

          def seq?
            is?(:seq)
          end

          def str?
            is?(:str)
          end

          def secure?
            is?(:secure)
          end

          def ref?
            is?(:ref)
          end

          def assign(attrs)
            attrs.each { |key, obj| send(key, obj) if respond_to?(key) }
          end

          def set(key, value)
            attrs[key] = value
          end

          def unset(*keys)
            keys.each { |key| attrs.delete(key) }
          end

          def ref
            :"#{namespace}/#{id}" if id
          end

          def namespace(str = nil)
            str ? attrs[:namespace] = str : attrs[:namespace] || registry_name
          end

          def id(str = nil)
            str ? attrs[:id] = str : attrs[:id] ||= def? ? registry_key : nil
          end

          def key(key = nil)
            key ? attrs[:key] = key : attrs[:key]
          end

          def expand?
            Array(attrs[:flags]).include?(:expand)
          end

          def expand_keys
            expand? ? [key].compact : []
          end

          def aliases(*strs)
            attrs[:aliases] = strs.flatten
          end

          def change?(name)
            Array(opts[:changes]).any? { |change| change[:change] == name }
          end

          def change(name, opts = {})
            changes << { change: name }.merge(opts)
          end

          def changes(*changes)
            attrs[:changes] ||= []
          end

          def deprecated(str = nil)
            str ? attrs[:deprecated] = str : attrs[:deprecated]
          end

          def description(str = nil)
            str ? attrs[:description] = str.chomp : attrs[:description]
          end

          def edge(*)
            flags << :edge
          end

          def example(str = nil)
            str ? attrs[:example] = str : attrs[:example]
          end

          def expand(*)
            flags << :expand
          end

          def export?
            !!attrs[:export]
          end

          def export(obj = true)
            attrs[:export] = obj
          end

          def flags
            attrs[:flags] ||= []
          end

          def internal?
            !!attrs[:internal]
          end

          def internal(*)
            flags << :internal
          end

          def normal?
            !!attrs[:normal]
          end

          def normal(*)
            attrs[:normal] = true
          end

          def required?
            !!attrs[:required]
          end

          def required(*)
            attrs[:required] = true
          end

          def summary(str = nil)
            str ? attrs[:summary] = str : attrs[:summary]
          end

          def supports(key, opts = nil)
            attrs.update(symbolize(to_strs(opts ? { key => opts } : key)))
          end

          def title(str = nil)
            str ? attrs[:title] = str : attrs[:title] || titleize(id)
          end

          def unique(*)
            flags << :unique
          end

          def opts
            only(compact(attrs), *self.class.opts)
          end

          def shapeshift(type, attrs = {})
            attrs = attrs.merge(self.attrs)
            attrs = attrs.merge(namespace: namespace, id: id, export: export?)
            Node[type].new(parent, attrs)
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
            node.attrs = node.attrs.dup
            node
          end

          def to_h
            Dump.new(self).to_h
          end

          def dump(opts = {})
            Dump.new(self, opts).dump
          end

          def inspect
            vars = ivars.reject { |name, value| name == :@parent || value.nil? }
            vars = vars.map { |name, value| "#{name}=#{value.inspect}" }.join(' ')
            name = (self.class.name || type.to_s.capitalize).sub('Travis::Yml::Schema::', '')
            "#<#{name}#{" #{vars}" unless vars.empty?}>"
          end

          def ==(other)
            self.class == other.class && id == other.id
          end
        end
      end
    end
  end
end
