# frozen_string_literal: true
require 'travis/yml/doc/schema/node'

module Travis
  module Yml
    module Doc
      module Schema
        class Any < Node
          include Enumerable

          def self.opts
            @opts ||= super + %i(detect)
          end

          attr_writer :schemas

          def matches?(value)
            any? { |schema| schema.matches?(value) }
          end

          def schemas
            @schemas ||= []
          end

          def [](ix)
            schemas[ix]
          end

          def first
            schemas.first
          end

          def each(&block)
            schemas.each(&block)
          end

          def type
            :any
          end

          def default?
            any?(&:default?)
          end

          def detect?
            !!opts[:detect]
          end

          def all_keys
            map(&:all_keys)
          end

          def to_h
            compact(id: id, key: key, type: type, schemas: schemas&.map(&:to_h), opts: opts)
          end
        end
      end
    end
  end
end
