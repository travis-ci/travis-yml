require 'travis/yaml/doc/value/node'

module Travis
  module Yaml
    module Doc
      module Value
        class Map < Node
          def initialize(parent, key, value, opts)
            fail ArgumentError.new("#{value} is not a Hash") unless value.is_a?(Hash)
            value.each { |_, value| value.parent = self }
            super
          end

          def type
            :map
          end

          def present?
            values.any?(&:present?)
          end

          def [](key)
            value[key]
          end

          def key?(key)
            value.key?(key)
          end

          def keys
            value.keys
          end

          def values
            value.values
          end

          def size
            value.size
          end

          def each(&block)
            value.each(&block)
          end

          def set(key, node)
            node.parent.delete(node) if node.parent && node.parent != self
            node.parent = self
            node.key = key
            value[key] = node
            self
          end

          def move(key, target)
            node = value.delete(key)
            set(target, node)
          end

          def prepend(other)
            other.each { |_, node| node.parent = self }
            @value = other.value.merge(value)
            self
          end

          def merge(other)
            value = Helper::Merge.apply(raw, other.raw)
            @value = value.map { |key, value| [key, Value.build(self, key, value, opts)] }.to_h
            self
          end

          def delete(node)
            value.delete(node.key)
            self
          end

          def drop
            value.clear
            self
          end

          def errored?
            super || values.any?(&:errored?)
          end

          def supporting
            return opts[:supporting] if opts[:supporting]
            keys  = SUPPORTING.select { |key| self[key] && self[key].present? }
            value = keys.map { |key| [key, self[key].serialize] }.to_h
            super.merge(value)
          end

          def raw
            value.map { |key, value| [key, value.raw] }.to_h
          end

          def serialize
            obj = compact(value.map { |key, obj| [key, obj.serialize] }.to_h)
            obj unless obj.empty?
          end

          def walk(level = 0, &block)
            super
            value.each { |_, value| value.walk(level + 1, &block) }
          end
        end
      end
    end
  end
end
