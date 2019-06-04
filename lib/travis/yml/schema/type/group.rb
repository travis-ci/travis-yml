require 'registry'
require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class Group < Node
          attr_writer :types

          def initialize(parent = nil, attrs = {})
            types(attrs[:types]) if attrs[:types]
            super
          end

          def type(*args)
            args.any? ? types(*args) : self.class.type
          end

          def types(*types)
            return @types ||= [] unless types.any?
            types = types.flatten
            attrs = types.last.is_a?(Hash) ? types.pop : {}
            types = types.map { |type| type.is_a?(Node) ? type : build(type, attrs) }
            self.types.concat(types)
          end

          def expand_keys
            super + types.map(&:expand_keys).flatten
          end
        end

        class Any < Group
          register :any

          opts %i(detect)

          def self.type
            :any
          end

          def detect(detect)
            attrs[:detect] = detect
          end
        end

        class All < Group
          register :all

          def self.type
            :all
          end
        end

        class One < Group
          register :one

          def self.type
            :one
          end
        end

        class Seq < Group
          register :seq

          def self.type
            :seq
          end
        end
      end
    end
  end
end
