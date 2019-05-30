require 'registry'
require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class Group < Node
          attr_writer :types

          def initialize(parent = nil, attrs = {})
            super
            types(attrs[:types]) if attrs[:types] # hrmmm.
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
          include Opts

          register :any

          opt_names %i(detect)

          def type(*args)
            args.any? ? types(*args) : :any
          end

          def detect(detect)
            attrs[:detect] = detect
          end
        end

        class All < Group
          register :all

          def type(*args)
            args.any? ? types(*args) : :all
          end
        end

        class One < Group
          register :one

          def type(*args)
            args.any? ? types(*args) : :one
          end
        end

        class Seq < Group
          register :seq

          def type(*args)
            args.any? ? types(*args) : :seq
          end
        end
      end
    end
  end
end
