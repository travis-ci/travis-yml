# frozen_string_literal: true
require 'travis/yaml/doc/change/base'
require 'travis/yaml/helper/common'
require 'travis/yaml/helper/memoize'

module Travis
  module Yaml
    module Doc
      module Change
        class Prefix < Base
          include Helper::Common, Helper::Memoize

          def apply
            prefix? ? prefix_node : node
          end

          def prefix?
            node.present? &&
            !!prefix &&
            !prefixed? &&
            !mapped? &&
            matches?
          end

          def prefixed?
            case node.type
            when :map then node.key?(prefix)
            when :seq then node.any? { |node| node.map? && node.key?(prefix) }
            else false
            end
          end

          def mapped?
            node.is?(:map) && node.keys.any? { |key| spec.known_key?(key) }
          end

          def matches?
            types.empty? || types.any? { |type| node.is?(type) }
          end

          def prefix_node
            other = prefixed
            return node unless present?(prefixed)
            # node.info :prefix, key: node.key, prefix: prefix
            send(:"prefix_on_#{node.parent.type}", other)
          end

          def prefix_on_seq(prefixed)
            node.parent.replace(node, prefixed)
            changed node.parent
          end

          def prefix_on_map(prefixed)
            other = node.parent.set(node.key, prefixed)
            changed other
          end

          def prefixed
            @prefixed ||= node.seq? ? prefixed_seq : prefixed_other
          end

          def prefixed_seq
            nodes = mapped_maps if spec.map?
            value = node.except(nodes).raw
            value = value.map { |value| including(value) }
            value = value.reject { |value| blank?(value) }
            return if value.empty?
            value = { prefix => value }
            other = build(node.parent, prefix, value, node.opts) # is this the right key??
            other = nodes.inject(other) { |node, other| node.merge(other) } if nodes
            other
          end

          def prefixed_other
            value = node.raw
            value = including(value)
            return unless present?(value)
            value = { prefix => value }
            value = build(node.parent, node.key, value, node.opts)
            value
          end

          def mapped_maps
            node.select { |map| mapped_map?(map) }
          end
          memoize :mapped_maps

          def mapped_map?(node)
            node.map? && node.keys.any? { |key| spec.known_key?(key) }
          end

          def prefix
            spec.prefix[:key]
          end

          def including(value)
            return value if included.empty?
            value.is_a?(Hash) ? only(value, *included) : nil
          end

          def included
            @including ||= Array(spec.prefix[:only])
          end

          def types
            @types ||= Array(spec.prefix[:type])
          end
        end
      end
    end
  end
end
