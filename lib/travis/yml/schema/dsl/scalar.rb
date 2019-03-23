# frozen_string_literal: true
require 'travis/yml/schema/dsl/node'

module Travis
  module Yml
    module Schema
      module Dsl
        class Scalar < Node
          register :scalar

          def self.type
            :scalar
          end

          def default(value, opts = nil)
            value = { value: value } unless value.is_a?(Hash)
            value = value.merge(opts) if opts
            value[:value] = value[:value].to_s if str?
            node.set :defaults, [value.merge(support(value))]
          end

          def support(value)
            support = only(value, :only, :except)
            support.map { |key, opts| [key, to_strs(opts)] }.to_h
          end
        end
      end
    end
  end
end
