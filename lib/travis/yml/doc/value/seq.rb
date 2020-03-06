# frozen_string_literal: true
require 'travis/yml/doc/value/node'

module Travis
  module Yml
    module Doc
      module Value
        class Seq < Node
          include Enumerable

          def type
            :seq
          end

          def first
            value.first
          end

          def index(node)
            value.index(node)
          end

          def each(&block)
            value.each(&block) && self
          end

          def all?(&block)
            value.all?(&block)
          end

          def map(&block)
            build(parent, key, value.map(&block).compact, opts)
          end

          def insert(ix, *others)
            others.each do |other|
              other.key = key
              other.parent = self
            end
            value.insert(ix, *others)
          end

          def replace(one, *others)
            if others.empty?
              clear
              insert(0, *one.value)
            else
              insert(index(one), *others.flatten)
              delete(one)
            end
          end

          def delete(*nodes)
            nodes.each { |node| value.delete(node) }
          end

          def flatten
            value.map { |value| value.is_a?(Seq) ? value.flatten : value }.flatten
          end

          def clear
            value.clear
          end

          def serialize(symbolize = true)
            value.map { |value| value.serialize(symbolize) }
          end
        end
      end
    end
  end
end
