require 'registry'
require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class Scalar < Node
          opts %i(defaults enum strict values)

          def default(value, opts = {})
            value = value.to_s if str?
            value = { value: value }.merge(opts)

            attrs[:defaults] ||= []
            attrs[:defaults] << value.merge(support(value))
          end

          def support(value)
            support = only(value, :only, :except)
            support.map { |key, attrs| [key, to_strs(attrs)] }.to_h
          end

          def strict(obj = true)
            attrs[:strict] = obj
          end

          def value(*objs)
            objs = objs.flatten
            opts = objs.last.is_a?(Hash) ? objs.pop : {}
            objs = objs.map { |obj| { value: obj }.merge(opts) }

            attrs[:enum] ||= []
            attrs[:enum].concat(to_strs(objs.map { |obj| obj[:value] })).uniq!

            attrs[:values] ||= {}
            attrs[:values] = merge(attrs[:values], to_vals(objs))
          end
          alias values value

          REMAP = {
            alias: :aliases
          }

          def to_vals(objs)
            keys = objs.map { |obj| obj[:value] }
            keys = keys.map { |key| key.is_a?(String) ? key.to_sym : key }
            vals = keys.zip(objs.map { |obj| to_val(obj) }).to_h
            merge(vals)
          end

          def to_val(obj)
            obj = obj.map { |key, obj| [REMAP[key] || key, obj] }.to_h

            obj = %i(aliases only except).inject(obj) do |obj, key|
              obj.merge(key => to_strs(obj[key]))
            end

            obj = %i(internal).inject(obj) do |obj, key|
              obj[:flags] = Array(obj[:flags]) << key if obj[key]
              except(obj, key)
            end

            except(obj, :value)
          end
        end

        class Bool < Scalar
          register :bool

          def type
            :bool
          end
        end

        class Num < Scalar
          register :num

          def type
            :num
          end
        end

        class Str < Scalar
          register :str

          opts %i(downcase format ignore_case vars)

          def type
            :str
          end

          def downcase(*)
            attrs[:downcase] = true
          end

          def format(format)
            attrs[:format] = format
          end

          def ignore_case(*)
            attrs[:ignore_case] = true
          end

          def vars(*vars)
            attrs[:vars] = vars.flatten
          end
        end

        class Secure < Node
          register :secure

          opts %i(strict)

          def type
            :secure
          end

          def id
            registry_key
          end

          def export?
            true
          end

          def strict(obj = true)
            attrs[:strict] = obj
          end
        end

        class Strs < Seq
          register :strs

          def type
            registry_key
          end

          def namespace
            :type
          end

          def id
            registry_key
          end

          def types
            [Str.new(self)]
          end

          def opts
            { min_size: 1 }
          end

          def export?
            true
          end
        end

        class Secures < Seq
          register :secures

          def type
            registry_key
          end

          def namespace
            :type
          end

          def id
            registry_key
          end

          def types
            [Secure.new(self)]
          end

          def export?
            true
          end
        end
      end
    end
  end
end
