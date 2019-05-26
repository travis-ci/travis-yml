require 'travis/yml/docs/schema/factory'

module Travis
  module Yml
    module Docs
      module Schema
        class Node
          include Helper::Obj

          attr_accessor :parents, :opts

          def initialize(parent, opts)
            @parents = [parent].compact
            @opts = opts
          end

          def type
            self.class.name.split('::').last.downcase.to_sym
          end

          def root?
            parents.empty?
          end

          def key
            opts[:key]
          end

          def namespace
            opts[:namespace]
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

          def example
            opts[:example]
          end

          def aliases
            opts[:aliases]
          end

          def enum
            opts[:enum] - deprecated_values if opts[:enum]
          end

          def flags
            Array(opts[:flags])
          end

          def deprecated?
            !!opts[:deprecated]
          end

          def deprecated
            opts[:deprecated]
          end

          def deprecated_values
            Array(opts[:values]).map { |value| value[:deprecated] && value[:value] }.compact.map(&:to_sym)
          end

          def internal?
            flags.include?(:internal)
          end

          def required?
            !!opts[:required]
          end

          def types
            [self]
          end

          def inspect
            type = self.class.name.sub('Travis::Yml::Docs::', '')
            pairs = compact(id: id, opts: opts.any? ? opts : nil)
            '#<%s %s>' % [type, pairs.map { |pair| pair.join('=') }.join(' ')]
          end
        end

        class Any < Node
          include Enumerable

          attr_accessor :schemas

          def each(&block)
            schemas.each(&block)
          end

          def types
            schemas.map(&:types).flatten.each do |type|
              next unless type.is_a?(Map)
              type.opts[:id] = id
              type.opts[:title] = title
            end
          end
        end

        class Seq < Node
          include Enumerable

          attr_accessor :schema

          def initialize(parent, opts, schema = nil)
            @schema = schema
            super(parent, opts)
          end

          def each(&block)
            yield schema
          end

          def types
            schema.types.map { |schema| Seq.new(nil, opts, schema) }
          end
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
          def type
            opts[:type]
          end
        end
      end
    end
  end
end
