module Travis
  module Yml
    module Docs
      module Schema
        class Node
          attr_accessor :parents, :opts

          def initialize(parent, opts)
            @parents = [parent].compact
            @opts = opts
          end

          def root?
            parents.empty?
          end

          def inspect
            'node'
          end

          def id
            opts[:id]
          end

          def summary
            opts[:summary]
          end

          def title
            opts[:title]
          end

          def description
            opts[:description]
          end
        end

        class Any < Node
          attr_accessor :schemas
        end

        class Seq < Node
          attr_accessor :schema
        end

        class Map < Node
          include Enumerable

          attr_accessor :mappings, :schema, :includes

          def [](key)
            mappings[key]
          end

          def each(&block)
            mappings.each(&block)
          end

          def includes
            @includes ||= []
          end
        end

        class Secure < Node
        end

        class Scalar < Node
        end

        module Factory
          include Yml::Helper::Obj
          extend self

          def build(parent, schema)
            if schema.is_a?(Array)
              schema.map { |schema| build(parent, schema) }
            elsif !schema.is_a?(Hash)
              raise "unexpected type #{schema.inspect}"
            elsif schema[:'$schema']
              schema_(parent, schema)
            elsif schema[:'$ref']
              ref(parent, schema)
            elsif secure?(schema)
              secure(parent, schema)
            elsif schema[:allOf]
              all(parent, schema)
            elsif schema[:anyOf]
              any(parent, schema)
            elsif schema[:oneOf]
              one(parent, schema)
            elsif schema[:type] == :boolean
              bool(parent, schema)
            elsif schema[:type] == :number
              num(parent, schema)
            elsif schema[:type] == :string
              str(parent, schema)
            elsif schema[:type] == :object
              map(parent, schema)
            elsif schema[:type] == :array
              seq(parent, schema)
            else
              raise "unexpected type #{schema.inspect}"
            end
          end

          def secure?(schema) # ugh.
            return true if schema[:anyOf] == Yml.schema[:definitions][:type][:secure][:anyOf]
            return true if schema[:type] == :object && schema[:properties] && schema[:properties].key?(:secure)
            false
          end

          def schema_(parent, schema)
            build(parent, except(schema, :'$schema', :definitions))
          end

          def all(parent, schema)
            nodes = schema[:allOf].map do |schema|
              schema = resolve(schema)
              key = %i(anyOf allOf oneOf).detect { |key| schema.key?(key) }
              build(parent, key ? join(key, schema) : schema)
            end

            node = nodes.first
            node.opts = normalize(except(schema, :allOf))
            node.includes = nodes[1..-1].reject { |node| [:languages, :support].include?(node.id) }
            node
          end

          def one(parent, schema)
            build(parent, join(:oneOf, schema))
          end

          def join(type, schema)
            objs = schema[type].map do |obj|
              obj = resolve(obj)
              key = %i(anyOf allOf oneOf).detect { |key| obj.key?(key) }
              key ? join(key, obj) : obj
            end

            # # TODO
            # objs = objs.reject { |obj| obj[:$id].to_s.start_with?('language') || obj[:$id].to_s.start_with?('support') }

            obj = merge(*objs)
            schema = except(schema, type)
            schema = merge(schema, except(obj, :$id, :title))
            schema = schema.merge(strict: true)
            schema
          end

          def join?(schema)
            %i(languages support).include?(schema[:$id])
          end

          def any(parent, schema)
            return build(parent, join(:anyOf, schema)) if join?(schema)
            node = Any.new(parent, normalize(schema))
            node.schemas = build(node, schema[:anyOf])
            node
          end

          def seq(parent, schema)
            node = Seq.new(parent, normalize(schema))
            node.schema = build(node, schema[:items]) if schema[:items]
            node
          end

          def map(parent, schema)
            node = Map.new(parent, normalize(schema))
            node.mappings = mappings(node, schema)
            if patterns = schema[:patternProperties]
              raise if patterns.size > 1
              node.opts[:format] = patterns.keys.first.to_s
              node.schema = build(node, patterns.values.first)
            end
            node
          end

          def mappings(parent, schema)
            map = schema[:properties] ? schema[:properties] : {}
            map = map.reject { |key, schema| Array(schema[:flags]).include?(:internal) }
            map.map { |key, schema| [key, build(parent, schema)] }.to_h
          end

          def secure(parent, schema)
            Secure.new(parent, normalize(schema))
          end

          def str(parent, schema)
            Scalar.new(parent, normalize(schema).merge(type: :str))
          end

          def bool(parent, schema)
            Scalar.new(parent, normalize(schema).merge(type: :bool))
          end

          def num(parent, schema)
            Scalar.new(parent, normalize(schema).merge(type: :num))
          end

          def ref(parent, schema)
            node = definition(schema[:'$ref']).dup
            node.parents << parent
            node.opts = node.opts.merge(normalize(schema))
            node
          end

          def definition(ref)
            definitions[ref] ||= build(nil, lookup(ref))
          end

          def lookup(ref)
            defs = Yml.schema[:definitions]
            keys = ref.to_s.sub('#/definitions/', '').split('/').map(&:to_sym)
            defn = keys.inject(defs) { |defs, key| defs[key] || unknown(ref) }
            defn || unknown(ref)
          end

          def resolve(schema)
            schema.key?(:'$ref') ? lookup(schema[:'$ref']) : schema
          end

          def unknown(ref)
            raise("unknown definition #{ref}")
          end

          def definitions
            @definitions ||= {}
          end

          DROP = %i(
            $ref
            additionalProperties
            allOf
            anyOf
            definitions
            enum
            examples
            items
            maxProperties
            minItems
            oneOf
            patternProperties
            properties
          )

          REMAP = {
            '$id':         :id,
            '$schema':     :uri,
            pattern:       :format,
            maxProperties: :max_size
          }

          def normalize(schema)
            schema = remap(schema)
            schema = schema.merge(id: schema[:id].to_sym) if schema[:id]
            schema = schema.merge(aliases: to_strs(schema[:aliases])) if schema[:aliases]
            schema = schema.merge(required: to_strs(schema[:required])) if schema[:required]
            schema = schema.merge(strict: strict?(schema)) if schema[:type] == :object
            schema = schema.merge(values: values(schema)) if schema[:enum]
            schema = schema.merge(defaults: defaults(schema)) if schema[:defaults]
            schema = schema.merge(support(schema)) if schema[:only] || schema[:except]
            except(schema, *DROP)
          end

          def defaults(schema)
            defaults = schema[:defaults]
            defaults = defaults.map { |obj| obj.merge(support(obj)) }
            defaults
          end

          def values(schema)
            values = schema[:values] || {}
            others = schema[:enum].map(&:to_s) - values.keys
            values = others.inject(values) { |values, key| values.merge(key => {}) }
            values = values.map { |key, value| value.merge(value: key.to_s) }
            values = values.map { |value| value.merge(support(value)) }
            values
          end

          def support(schema)
            only(schema, :only, :except).map { |key, opts| [key, stringify(opts)] }.to_h
          end

          def strict?(schema)
            return schema[:strict] if schema.key?(:strict)
            return false if schema.key?(:patternProperties)
            false?(schema[:additionalProperties])
          end

          def remap(hash)
            hash.map { |key, value| [REMAP[key] || key, value] }.to_h
          end
        end
      end
    end
  end
end
