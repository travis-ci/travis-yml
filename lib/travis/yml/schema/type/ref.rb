# frozen_string_literal: true
require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class Ref < Node
          include Opts

          register :ref

          # allow all opt_names defined on any type
          opt_names Node.registry.values.map(&:opt_names).flatten.uniq - Node.opt_names

          def type
            :ref
          end

          def secure?
            id == :secure
          end

          # def ref
          #   "#{namespace}/#{id}".to_sym
          # end

          def namespace(str = nil)
            str ? attrs[:namespace] = str : attrs[:namespace]
          end

          def id(str = nil)
            str ? attrs[:id] = str : attrs[:id]
          end

          def strict(obj = true)
            attrs[:strict] = obj
          end

          def export?
            false
          end

          def lookup
            Node.exports[ref]
          end
        end
      end
    end
  end
end
