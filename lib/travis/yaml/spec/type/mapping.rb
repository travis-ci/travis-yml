module Travis
  module Yaml
    module Spec
      module Type
        class Mapping < Struct.new(:key, :types)
          include Helper::Common

          KEYS = [:only, :except]

          def spec
            { key: key, types: types.map(&:spec) }
          end

          def merge(other)
            types.each.with_index do |type, ix|
              one  = Conditions.new(type.opts)
              opts = other.types[ix].opts
              type.opts.merge!(one.merge(opts).to_h)
            end
            self
          end
        end
      end
    end
  end
end
