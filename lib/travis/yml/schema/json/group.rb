# frozen_string_literal: true
require 'travis/yml/schema/json/node'

module Travis
  module Yml
    module Schema
      module Json
        class Group < Node
          def definitions
            export? ? merge(defn(to_h), *jsons(node).map(&:definitions)) : {}
          end

          def to_h
            schemas = jsons(node).map(&:schema)
            schemas = schemas.map { |schema| schema.key?(key) ? schema[key] : schema }
            schemas = schemas.flatten.uniq
            # schemas = normals(schemas) if type == :any # too aggressive
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
