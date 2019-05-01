# frozen_string_literal: true
require 'travis/yml/schema/json/node'

module Travis
  module Yml
    module Schema
      module Json
        class Group < Node
          def to_h
            schemas = node.reject(&:internal?).map(&:schema)
            schemas = schemas.map { |schema| schema.key?(key) ? schema[key] : schema }
            schemas = schemas.flatten.uniq
            compact({ key => schemas }.merge(opts))
          end
        end

        class All < Group
          register :all

          def key
            :allOf
          end
        end

        class Any < Group
          register :any

          def key
            :anyOf
          end
        end

        class One < Group
          register :one

          def key
            :oneOf
          end
        end
      end
    end
  end
end
