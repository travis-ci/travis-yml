# frozen_string_literal: true
require 'travis/yml/schema/json/map'

module Travis
  module Yml
    module Schema
      module Json
        class Schema < Node
          register :schema

          SCHEMA = {
            '$schema': 'http://json-schema.org/draft-04/schema#'
          }

          DEFINITIONS = {
            secure: {
              '$id': :secure,
              anyOf: [
                {
                  type: :object,
                  properties: {
                    secure: {
                      type: :string
                    }
                  },
                  additionalProperties: false,
                  maxProperties: 1,
                  normal: true
                },
                {
                  type: :string,
                  normal: true
                }
              ]
            },
            secures: {
              '$id': :secures,
              anyOf: [
                {
                  type: :array,
                  items: { '$ref': '#/definitions/secure' },
                  normal: true
                },
                {
                  '$ref': '#/definitions/secure'
                }
              ]
            },
            strs: {
              '$id': :strs,
              anyOf: [
                {
                  type: :array,
                  minItems: 1,
                  items: {
                    anyOf: [
                      { type: :string }
                    ]
                  },
                  normal: true
                },
                {
                  type: :string
                }
              ]
            }
          }

          def schema
            schema = SCHEMA
            schema = schema.merge(
              title: node.title,
              definitions: definitions,
              expand: node.expand,
            )
            schema.merge(all)
          end

          ORDER = [:type, :addon, :deploy, :language, :notification]

          def definitions
            objs = merge(*jsons(Type::Node.exports.values).map(&:definitions))
            objs = sort(objs)
            objs = merge(DEFINITIONS, objs)
            objs
          end

          def sort(objs)
            objs = objs.map { |key, objs| [key, objs.sort.to_h] }.to_h
            objs.sort { |lft, rgt| ORDER.index(lft[0]) <=> ORDER.index(rgt[0]) || 0 }.to_h
          end

          def all
            All.new(node.schema).schema
          end
        end
      end
    end
  end
end

