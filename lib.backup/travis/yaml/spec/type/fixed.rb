# frozen_string_literal: true
require 'travis/yaml/spec/type/scalar'

module Travis
  module Yaml
    module Spec
      module Type
        class Fixed < Scalar
          register :fixed

          def value(*values)
            opts = values.last.is_a?(Hash) ? values.pop : {}
            values.each do |value|
              self.values << { value: value.to_s }.merge(with_aliases(opts))
            end
          end

          def values
            opts[:values] ||= []
          end

          def with_aliases(opts)
            opts[:alias] = Array(opts[:alias]).map(&:to_s) if opts[:alias]
            opts
          end
        end
      end
    end
  end
end
