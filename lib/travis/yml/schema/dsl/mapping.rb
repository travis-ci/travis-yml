# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Dsl
        class Mapping < Obj.new(:key, :dsl, :opts)
          def define
            opts.each do |key, value|
              case key
              when :only, :except
                dsl.supports(key => value)
              else
                dsl.send(key, value)
              end
            end
          end

          def key_opts
            support = node.support
            support = support.map { |key, opts| [key, self.key => opts] }.to_h

            compact(
              aliases: compact(key => node.aliases),
              required: node.required? ? [key] : nil,
              unique: node.unique? ? [key] : nil,
              only: support[:only],
              except: support[:except]
            )
          end

          def node
            dsl.node
          end
        end
      end
    end
  end
end
