# frozen_string_literal: true
require 'travis/yaml/helper/common'
require 'travis/yaml/spec/type/conditions'
require 'travis/yaml/support/registry'
require 'travis/yaml/support/obj'

module Travis
  module Yaml
    module Spec
      module Type
        class Node < Obj.new(parent: nil, opts: {})
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

          def initialize(*)
            super
            define if respond_to?(:define)
          end

          def root
            parent ? parent.root : self
          end

          def root?
            parent.nil?
          end

          def strict(strict = true)
            opts[:strict] = strict
          end

          def underscore(underscore = true)
            opts[:underscore] = underscore
          end

          def aliases(aliases)
            opts[:alias] ||= []
            opts[:alias] += Array(aliases).map(&:to_s)
          end

          def change(name, opts = {})
            changes << compact({ name: name }.merge(opts))
          end

          def changes
            opts[:change] ||= []
          end

          def validate(name, opts = {})
            validations << compact({ name: name }.merge(opts))
          end

          def validations
            opts[:validate] = []
          end

          def secure
            opts[:secure] = true
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

          def deprecated(info)
            opts[:deprecated] = info
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

          # def opts
          #   @opts ||= {}
          # end

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
