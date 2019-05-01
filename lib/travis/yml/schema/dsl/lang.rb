# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Dsl
        class Lang < Map
          register :lang

          def self.type
            :lang
          end

          def initialize(*)
            super
            support
            langs.each { |node| node.set(:enum, [registry_key]) }
            langs.each { |node| node.set(:values, registry_key => {}) }
          end

          def aliases(*aliases)
            langs.each { |node| node.set(:values, registry_key => { aliases: to_strs(aliases) }) }
          end

          def deprecated(obj)
            langs.each { |node| node.set(:values, registry_key => { deprecated: obj }) }
          end

          def map(key, opts = {})
            opts = opts.merge(only: { language: registry_key })
            support.map(key, except(opts, :expand))
            opts[:to] ||= :seq
            super
          end

          def langs
            Def::Language.instances.map(&:node)
          end
          memoize :langs

          def support
            self.class::Support.new(self)
          end
          memoize :support
        end

        class Support < Map
          # Matrix keys need to be mapped as normal keys on Support, which ends
          # up being included in matrix entry and deploy conditions. Therefore
          # we default the type to a :str, rather than a :seq. if a given type
          # is a seq, we pick it's first type. This means that on languages we
          # cannot map to a seq with multiple types.
          def map(key, opts = {})
            opts[:to] = opts[:to] ? unwrap(opts[:to]) : :str
            super
          end

          def unwrap(type)
            const = resolve(type)
            const < Dsl::Seq ? const.new.node.types.map(&:type).first : type
          end
        end
      end
    end
  end
end
