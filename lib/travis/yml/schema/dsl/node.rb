# frozen_string_literal: true
require 'registry'

module Travis
  module Yml
    module Schema
      module Dsl
        class Node < Obj.new(:parent, :node)
          extend Forwardable
          include Registry

          class << self
            def type
              :node
            end

            def build(parent, type, opts = {})
              Node.resolve(type).new(parent, opts)
            end

            # We only want to instantiate and define types in Schema::Def once,
            # in order to optimize performance. Otherwise all deploy providers
            # have to define all languages in order to include language support
            # keys on deploy conditions (e.g. deploy.on.rvm), which means ~1200
            # times the work (~40 providers, ~30 languages) for includes,
            # slowing the process down from ~0.12s to ~1.4s.

            def new(parent = nil, opts = {})
              if registry_key && opts.empty? && obj = Type::Node.exports[registry_key]
                raise if opts.any?
                obj.export? ? ref(parent, obj) : super(parent, obj)
                # super(parent, obj)
              else
                obj = Type::Node[type].new(parent&.node, id: registry_key)
                node = super(parent, obj)
                node.assign(opts)
                node.define

                if node.export?
                  obj = Type::Expand.apply(obj)
                  Type::Node.exports[obj.id] = obj
                  ref(node.parent, obj)
                else
                  node
                end
              end
            end

            def ref(parent, obj)
              Ref.new(parent, namespace: obj.namespace, id: obj.id)
            end

            def resolve(type)
              type.is_a?(Class) ? type : self[type]
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
            return nil if root?
            parent.is?(*types) ? parent : parent.parent(*types)
          end

          def is?(type)
            is_a?(Node[type])
          end

          def enum?
            is?(:enum)
          end

          def lang?
            is?(:lang)
          end

          def map?
            is?(:map)
          end

          def str?
            is?(:str)
          end

          def define
          end

          def assign(opts)
            opts.each do |key, value|
              case key
              when :only, :except
                supports(key => value)
              else
                send(key, value)
              end
            end
          end

          def aliases(*aliases)
            node.set :aliases, aliases.flatten
          end
          alias alias aliases

          def changes(*objs)
            objs = objs.flatten
            opts = objs.last.is_a?(Hash) && !objs.last.key?(:change) ? objs.pop : {}
            changes = objs.map { |obj| obj.is_a?(Hash) ? obj : { change: obj } }
            changes = changes.map { |obj| obj.merge(opts) }
            node.set :changes, changes
          end
          alias change changes

          def deprecated(*)
            node.set :deprecated, true
          end

          def description(description)
            node.set :description, description.strip
          end

          def expand(*)
            node.set :flags, [:expand]
          end

          def export?
            node.export?
          end

          def export(*)
            node.export
          end

          def edge(_ = nil)
            node.set :flags, [:edge]
          end

          def example(examples)
            node.set :examples, examples
          end
          alias examples example

          def internal(*)
            node.set :flags, [:internal]
          end

          def key(key)
            node.set :key, key
          end

          def namespace(namespace)
            node.set :namespace, namespace
          end

          def normal(*)
            node.set :normal, true
          end

          def required(*)
            node.set :required, true
          end

          def title(title)
            node.set :title, title
          end

          def unique(*)
            node.set :unique, true
          end

          def supports(key, opts = nil)
            opts = opts ? { key => opts } : key
            opts = symbolize(to_strs(opts))
            opts.each do |key, opts|
              node.set :support, key => opts
            end
          end

          def definitions
            node.definitions
          end

          def schema
            node.schema
          end
        end
      end
    end
  end
end
