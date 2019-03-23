# frozen_string_literal: true
require 'travis/yaml/spec/type/node'

module Travis
  module Yaml
    module Spec
      module Type
        class Scalar < Node
          register :scalar

          def default(value, opts = {})
            value = value.to_s if value.is_a?(Symbol)
            defaults << { value: value }.merge(opts)
          end

          def defaults
            opts[:defaults] ||= []
          end

          def cast(type)
            opts[:cast] = type
          end

          def downcase
            opts[:downcase] = true
          end
        end
      end
    end
  end
end
