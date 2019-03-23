# frozen_string_literal: true
require 'travis/yaml/doc/value/node'

module Travis
  module Yaml
    module Doc
      module Value
        class Scalar < Node
          include Helper::Common

          def initialize(parent, key, value, opts)
            fail ArgumentError.new("#{value} cannot be a #{value.class}") if [Node, Array, Hash].include?(value.class)
            super
          end

          def type
            :scalar
          end

          def is?(type)
            super || type == :fixed || (type == :bool && bool?) || (type == :str && str?)
          end

          def present?
            super(value)
          end

          def set(value)
            @value = value
            self
          end

          def drop
            set(nil)
          end

          def raw
            value
          end

          def serialize
            value
          end
        end
      end
    end
  end
end
