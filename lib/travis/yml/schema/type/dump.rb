# frozen_string_literal: true
begin
  require 'awesome_print'
rescue LoadError
end

module Travis
  module Yml
    module Schema
      module Type
        class Dump < Obj.new(:node, opts: {})
          AI = {
            indent:        -2,     # Number of spaces for indenting.
            index:         false,  # Display array indices.
            multiline:     true,   # Display in multiple lines.
            plain:         true,   # Use colors.
            ruby19_syntax: true,   # Use Ruby 1.9 hash syntax in output.
          }

          def dump
            str = ai(to_h(node))
            str = mark(str)
            str
          end

          def to_h(node = self.node)
            send(node.type, node)
          end

          def map(node)
            obj(node).merge(map: node.map { |key, node| [key, to_h(node)] }.to_h)
          end

          alias schema map

          def group(node)
            obj(node).merge(types: node.map { |node| to_h(node) })
          end

          alias any group
          alias all group
          alias one group
          alias secures group
          alias strs group

          def seq(node)
            obj(node).merge(types: node.map { |node| to_h(node) })
          end

          def ref(node)
            obj(node).merge(ref: node.ref)
          end

          def obj(node)
            ids << node.object_id

            compact(
              id: node.id,
              # obj_id: node.object_id,
              type: node.type,
              normal: node.normal? ? true : nil,
              export: node.export? ? true : nil,
              # examples: node.examples
            ).merge(compact(node.opts))
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

          def mark(str)
            str = colorize(str, opts[:mark], :green) if opts[:mark]
            str = dups.inject(str) { |str, id| colorize(str, id.to_s, :red) }
            str
          end

          def dups
            ids.select { |id| ids.count(id) > 1 }.uniq
          end

          def ids
            @ids ||= []
          end

          def colorize(str, chars, color)
            str.gsub(chars) { |str| send(color, str) }
          end

          def red(str)
            "\e[31m#{str}\e[0m"
          end

          def green(str)
            "\e[32m#{str}\e[0m"
          end
        end
      end
    end
  end
end
