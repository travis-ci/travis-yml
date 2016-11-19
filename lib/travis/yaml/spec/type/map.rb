require 'travis/yaml/spec/type/mapping'
require 'travis/yaml/spec/type/mappings'
require 'travis/yaml/spec/type/node'

module Travis
  module Yaml
    module Spec
      module Type
        class Map < Node
          register :map

          def include(*features)
            opts[:include] ||= []
            opts[:include] += features
          end

          def skip?(key)
            skip.include?(key)
          end

          def skip
            opts[:skip] || []
          end

          def type(*types)
            return @types if types.empty?
            opts = types.last.is_a?(Hash) ? types.pop : {}
            @types = resolve(types, opts)
          end

          def types
            @types ||= []
          end

          def prefix(prefix, opts = {})
            opts[:type] = Array(opts[:type]) if opts[:type]
            self.opts[:prefix] = { key: prefix }.merge(opts)
          end

          def matrix(key, opts = {})
            map(key, opts.merge(expand: true))
          end

          def maps(*keys)
            opts = keys.last.is_a?(Hash) ? keys.pop : {}
            keys.each { |key| map(key, opts.dup) }
          end

          def map(key, opts = {})
            opts  = normalize_opts(opts)
            types = resolve(opts.delete(:to) || key, opts) + self.types
            mappings.add(key, key, types)
            root.expand(key) if opts[:expand]
          end

          def resolve(types, opts)
            Array(types).map do |type|
              next type.new(self) if type.is_a?(Class)
              const = Node[[:bool, :str].include?(type) ? :scalar : type]
              opts  = opts.merge(cast: :bool) if type == :bool
              opts  = opts.merge(strict: false) if const == Map
              const.new(self, opts)
            end
          end

          def normalize_opts(opts)
            opts[:defaults] = [{ value: opts.delete(:default) }] if opts[:default]
            opts[:values]   = normalize_values(opts[:values]) if opts[:values]
            opts[:alias]    = normalize_aliases(opts[:alias]) if opts[:alias]
            opts
          end

          def normalize_values(values)
            Array(values).map { |value| { value: value.to_s } }
          end

          def normalize_aliases(aliases)
            Array(aliases).map(&:to_s)
          end

          def mappings
            @mappings ||= Mappings.new
          end

          def spec
            spec = {}
            spec[:name] = registry_key unless registry_key == :map
            spec[:type] = :map
            spec = spec.merge(opts)
            spec[:map] = mappings.spec
            spec[:types] = Array(types).map(&:spec) unless types.empty?
            compact(spec)
          end

          def opts
            @opts ||= { strict: true }.merge(super)
          end
        end
      end
    end
  end
end
