require 'registry'
require 'travis/yml/schema/type/node'

module Travis
  module Yml
    module Schema
      module Type
        class Scalar < Node
          include Opts

          opt_names %i(defaults enum strict values)

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
            attrs[:values].update(to_vals(objs))
          end
          alias values value

          REMAP = {
            alias: :aliases
          }

          def to_vals(objs)
            keys = objs.map { |obj| obj[:value] }
            keys = keys.map { |key| key.is_a?(String) ? key.to_sym : key }
            objs = objs.map { |obj| obj.map { |key, obj| [REMAP[key] || key, obj] }.to_h }
            objs = objs.map { |obj| obj.merge(aliases: to_strs(obj[:aliases])) }
            objs = objs.map { |obj| obj.merge(only: to_strs(obj[:only])) }
            objs = objs.map { |obj| obj.merge(except: to_strs(obj[:except])) }
            objs = keys.zip(objs)
            vals = objs.map { |key, obj| [key, except(obj, :value)] }.to_h
            merge(compact(vals))
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
          include Opts

          register :str
          opt_names %i(downcase format vars)

          def type
            :str
          end

          def downcase(*)
            attrs[:downcase] = true
          end

          def format(format)
            attrs[:format] = format
          end

          def vars(*vars)
            attrs[:vars] = vars.flatten
          end
        end

        class Secure < Node
          include Opts

          register :secure
          opt_names %i(strict)

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
