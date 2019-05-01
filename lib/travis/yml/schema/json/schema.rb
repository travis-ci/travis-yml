# frozen_string_literal: true
require 'travis/yml/schema/json/map'

module Travis
  module Yml
    module Schema
      module Json
        class Schema < All
          register :schema

          SCHEMA = {
            '$schema': 'http://json-schema.org/draft-04/schema#'
          }

          def schema
            merge(SCHEMA, definition, definitions: definitions, expand: expand_keys)
          end

          def definitions
            objs = Hash.new { |hash, key| hash[key] = {} }
            node.exports.each { |node| objs[node.namespace][node.id] = node.definition }
            objs = sort(objs)
            objs
          end

          def expand_keys
            node.expand_keys.sort
          end

          ORDER = [:type, :addon, :deploy, :language, :notification]

          def sort(objs)
            objs = objs.map { |key, objs| [key, objs.sort.to_h] }.to_h
            objs.sort { |lft, rgt| ORDER.index(lft[0]) <=> ORDER.index(rgt[0]) || 0 }.to_h
          end
        end
      end
    end
  end
end

