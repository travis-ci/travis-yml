# frozen_string_literal: true

module Travis
  module Yml
    module Doc
      module Value
        module Factory
          class << self
            TYPES = {
              Hash       => :map,
              Array      => :seq,
              TrueClass  => :bool,
              FalseClass => :bool,
              Float      => :num,
              Integer    => :num,
              String     => :str,
              Symbol     => :str,
              NilClass   => :none
            }

            def build(parent, key, value, opts = {})
              # puts caller[0..15] if key == :enabled
              value = value.value if value.is_a?(Node)
              type = TYPES[value.class] || raise("Unknown type: #{value}")
              send(type, parent, key, value, opts)
            end

            private

              def none(parent, key, value, opts)
                None.new(parent, key, value, opts)
              end

              def bool(parent, key, value, opts)
                Bool.new(parent, key, value, opts)
              end

              def num(parent, key, value, opts)
                Num.new(parent, key, value, opts)
              end

              def str(parent, key, value, opts)
                Str.new(parent, key, value.to_s, opts)
              end

              def map(parent, key, value, opts)
                const = secure?(value) ? Secure : Map
                map = const.new(parent, key, nil, opts)
                map.value = value.map { |key, obj| [key, build(map, key, obj, opts)] }.to_h
                map
              end

              def seq(parent, key, value, opts)
                seq = Seq.new(parent, key, nil, opts)
                seq.value = value.map { |value| build(seq, key, value, opts) }
                seq
              end

              def secure?(value)
                value.key?('secure') && value.keys.size == 1
              end
          end

          def build(parent, key, value, opts)
            Factory.build(parent, key, value, opts)
          end
        end
      end
    end
  end
end
