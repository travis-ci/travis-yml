# frozen_string_literal: true
require 'registry'

module Travis
  module Yml
    module Schema
      module Dsl
        class Node < Obj.new(:parent, :node)
          extend Forwardable
          include Registry

          registry :type

          class << self
            def type
              :node
            end

            # We only want to instantiate and define types in Schema::Def once,
            # in order to optimize performance. Otherwise all deploy providers
            # have to define all languages in order to include language support
            # keys on deploy conditions (e.g. deploy.on.rvm), which means ~1200
            # times the work (~40 providers, ~30 languages) for includes,
            # slowing the process down from ~0.12s to ~1.4s.

            def new(parent = nil, opts = {})
              caching(opts) do
                # could all this now live in initialize?
                obj = Type::Node[type].new(parent&.node, namespace: registry_name, id: id)
                node = super(parent, obj)
                node.assign(opts)
                node.before_define
                node.define
                node.after_define
                node
              end
            end

            def caching(opts)
              if cache?(opts) && node = Node.cache[registry_full_key]
                node
              else
                node = yield
                Node.cache[registry_full_key] = node if cache?(opts)
                node
              end
            end

            def cache?(opts)
              !!id && opts.empty?
            end

            def cache
              @cache ||= {}
            end

            def id
              registry_key if def?
            end

            def def?
              name.to_s.include?('Def::')
            end

            # move to Registry
            def registry_full_key
              [registry_name, registry_key].join('.').to_sym
            end
          end

          def build(parent, type, opts = {})
            resolve(type).new(parent, opts)
          end

          def resolve(type)
            type.is_a?(Class) ? type : self.class.lookup(type)
          end

          def root
            parent ? parent.root : self
          end

          def root?
            parent.nil?
          end

          def parent(*types)
            return super() if types.empty?
            raise # remove this
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

          def before_define
          end

          def define
          end

          def after_define
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

          def deprecated(obj = true)
            node.set :deprecated, obj
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

          def normal(*)
            node.set :normal, true
          end

          def required(*)
            node.set :required, true
          end

          def summary(summary)
            node.set :summary, summary
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
            opts.each { |key, opts| node.set key, opts }
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
