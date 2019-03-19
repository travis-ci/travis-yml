# frozen_string_literal: true
require 'travis/yaml/doc/change/base'

module Travis
  module Yaml
    module Doc
      module Change
        class Env < Base
          def apply
            case spec.type
            when :seq    then to_vars
            when :scalar then node.scalar? ? node : to_var
            else node
            end
          end

          private

            # TODO this is probably inefficient?

            def to_vars
              vars = vars_for(node)
              vars = build(node.parent, node.key, vars, node.opts)
              return node if vars.raw == node.raw
              parent = node.parent.set(node.key, vars)
              changed parent
            end

            def to_var
              var = var_for(node)
              var = build(node.parent, node.key, var, node.opts)
              return node if var.raw == node.raw
              changed node.parent.set(node.key, var)
            end

            def vars_for(node)
              case node.type
              when :map    then node.value.to_h.map { |key, node| [key, node.raw].join('=') }
              when :seq    then node.value.to_a.map { |node| vars_for(node) }.flatten
              when :scalar then [node]
              when :secure then [node]
              end
            end

            def var_for(node)
              case node.type
              when :map    then node.value.to_h.map { |key, node| [key, node.raw].join('=') }.join(' ')
              when :seq    then node.value.to_a.map { |node| var_for(node) }.flatten.compact.join(' ')
              when :scalar then node.value
              when :secure then nil
              end
            end
        end
      end
    end
  end
end
