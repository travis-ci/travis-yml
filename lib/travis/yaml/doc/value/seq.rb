require 'travis/yaml/doc/value/node'

module Travis
  module Yaml
    module Doc
      module Value
        class Seq < Node
          def initialize(parent, key, value, opts)
            fail ArgumentError.new("#{value} is not an Array") unless value.is_a?(Array)
            value.each do |node|
              node.parent = self
              node.key = key
            end
            super
          end

          def key=(key)
            value.each { |node| node.key = key }
            super
          end

          def type
            :seq
          end

          def present?
            value.any?(&:present?)
          end

          def [](ix)
            value[ix]
          end

          def first
            value.first
          end

          def index(child)
            value.index(child)
          end

          def each(&block)
            value.each(&block)
          end

          def map(&block)
            Value.build(parent, key, value.map(&block), opts)
          end

          def select(&block)
            Value.build(parent, key, value.select(&block), opts)
          end

          def inject(*args, &block)
            Value.build(parent, key, value.inject(*args, &block), opts)
          end

          def any?(&block)
            value.any?(&block)
          end

          def all?(&block)
            value.all?(&block)
          end

          def include?(other)
            value.include?(other)
          end

          def push(child)
            child.key = key
            child.parent = self
            value.push(child)
            self
          end

          def insert(ix, *others)
            others.each do |other|
              other.key = key
              other.parent = self
            end
            value.insert(ix, *others)
            self
          end

          def replace(node, *nodes)
            if nodes.empty?
              drop
              insert(0, *node.value)
            else
              insert(index(node), *nodes.flatten)
              delete(node)
            end
            self
          end

          def delete(*nodes)
            nodes.each { |node| value.delete(node) }
            self
          end

          def except(other)
            values = value.reject { |value| other.include?(value) }.to_a
            Value.build(parent, key, values, opts)
          end

          def merge
            other = inject(&:merge)
            other.parent = parent
            other
          end

          def drop
            value.clear
            self
          end

          def errored?
            super || value.any?(&:errored?)
          end

          def raw
            value.map(&:raw)
          end

          def serialize
            obj = value.map(&:serialize)
            obj = obj.reject { |obj| Helper::Common.blank?(obj) }
            obj unless obj.empty?
          end

          def walk(level = 0, &block)
            super
            value.each { |value| value.walk(level + 1, &block) }
          end
        end
      end
    end
  end
end
