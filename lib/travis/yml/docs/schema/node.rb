module Travis
  module Yml
    module Docs
      module Schema
        class Node
          include Helper::Obj

          attr_accessor :parent, :opts

          def initialize(parent, opts)
            @parent = parent
            @opts = opts
          end

          def type
            self.class.name.split('::').last.downcase.to_sym
          end

          def included
            @included = true
          end

          def included?
            !!@included
          end

          def root?
            parent.nil?
          end

          def any?
            type == :any
          end

          def seq?
            type == :seq
          end

          def map?
            type == :map
          end

          def str?
            type == :str
          end

          def strs?
            id == :strs
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

          def description
            opts[:description]
          end

          def defaults
            opts[:defaults]
          end

          def example
            opts[:example]
          end

          def aliases
            opts[:aliases]
          end

          def enum
            opts[:enum] - deprecated_values - internal_values if opts[:enum]
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
            values.map { |value| value[:deprecated] && value[:value] }.compact.map(&:to_s)
          end

          def internal_values
            values.select { |value| Array(value[:flags]).include?(:internal) }.map { |value| value[:value] }.map(&:to_s)
          end

          def internal?
            flags.include?(:internal)
          end

          def normal?
            !!opts[:normal]
          end

          def prefix
            opts[:prefix]
          end

          def required?
            !!opts[:required]
          end

          def see
            opts[:see]
          end

          def summary
            opts[:summary]
          end

          def title
            opts[:title]
          end

          def values
            Array(opts[:values])
          end

          def expand
            [self]
          end

          def examples
            Examples.build(nil, self).examples.map do |example|
              key ? { key => example } : example
            end
          end

          def dup
            node = super
            node.opts = opts.dup
            node
          end

          def inspect
            type = self.class.name.sub('Travis::Yml::Docs::', '')
            pairs = compact(id: id, opts: opts.any? ? opts : nil)
            '#<%s %s>' % [type, pairs.map { |pair| pair.join('=') }.join(' ')]
          end
        end
      end
    end
  end
end
