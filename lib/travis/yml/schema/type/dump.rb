# frozen_string_literal: true
require 'awesome_print'

module Travis
  module Yml
    module Schema
      module Type
        class Dump < Obj.new(:node)
          AI = {
            indent:        -2,     # Number of spaces for indenting.
            index:         false,  # Display array indices.
            multiline:     true,   # Display in multiple lines.
            plain:         true,   # Use colors.
            ruby19_syntax: true,   # Use Ruby 1.9 hash syntax in output.
          }

          def dump
            ai(to_h(node))
          end

          def to_h(node)
            send(node.type, node)
          end

          def map(node)
            obj(node).merge(map: node.map { |key, node| [key, to_h(node)] }.to_h)
          end

          def group(node)
            obj(node).merge(schemas: node.map { |node| to_h(node) })
          end
          alias any group
          alias all group
          alias one group

          def seq(node)
            obj(node).merge(schemas: node.map { |node| to_h(node) })
          end

          def obj(node)
            compact( id: node.id, type: node.type, key: node.key, opts: node.opts)
          end
          alias secure obj
          alias enum obj
          alias str obj
          alias num obj
          alias bool obj

          def ai(obj)
            str = obj.ai(AI)
            str = str.gsub(/(\w+) +:/, '\1:')
            str = str.gsub('$ref', "'$ref'")
            str = str.gsub('$id', "'$id'")
            str = str.gsub('"', "'")
            str
          end
        end
      end
    end
  end
end
