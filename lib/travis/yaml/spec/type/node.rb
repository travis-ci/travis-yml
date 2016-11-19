require 'travis/yaml/helper/common'
require 'travis/yaml/spec/type/conditions'
require 'travis/yaml/support/registry'

module Travis
  module Yaml
    module Spec
      module Type
        class Node
          include Helper::Common, Registry

          class << self
            include Helper::Common

            def type
              @type ||= begin
                const = ancestors.detect { |const| const.name.to_s.include?('Spec::Type') }
                underscore(const.name.split('::').last).to_sym
              end
            end
          end

          attr_reader :parent

          def initialize(parent = nil, opts = {})
            @parent = parent
            @opts = opts
            define if respond_to?(:define)
          end

          def root
            parent ? parent.root : self
          end

          def aliases(name = nil)
            aliases = opts[:alias] ||= []
            return aliases unless name
            aliases << name.to_s
            aliases.uniq!
          end

          def normalize(name, opts = {})
            normalizers << compact({ name: name }.merge(opts))
          end

          def normalizers
            opts[:normalize] = []
          end

          def validate(name, opts = {})
            conform(name, opts.merge(stage: :validate))
          end

          def prepare(name, opts = {})
            conform(name, opts.merge(stage: :prepare))
          end

          def conform(name, opts = {})
            conformers << compact({ name: name }.merge(opts))
          end

          def conformers
            opts[:conform] = []
          end

          def required
            opts[:required] = true
          end

          def flagged
            opts[:flagged] = true
          end

          def edge
            opts[:edge] = true
          end

          def only(opts)
            @opts = self.opts.merge(Conditions.new(only: opts).to_h)
          end

          def except(opts)
            @opts = self.opts.merge(Conditions.new(except: opts).to_h)
          end

          def expand(key)
            expand_keys << key unless expand_keys.include?(key)
          end

          def expand_keys
            opts[:expand] ||= []
          end

          def opts
            @opts ||= {}
          end

          def spec
            spec = {}
            spec = spec.merge(name: registry_key) unless [:scalar, :fixed].include?(registry_key)
            spec = spec.merge(type: type)
            spec = spec.merge(opts)
            spec
          end

          def type
            self.class.type
          end
        end
      end
    end
  end
end
