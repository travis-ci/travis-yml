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

          def before_define
            language.set(:enum, [registry_key])
            language.set(:values, registry_key => {})
          end

          def aliases(*aliases)
            language.set(:values, registry_key => { aliases: to_strs(aliases) })
          end

          def deprecated(obj)
            language.set(:values, registry_key => { deprecated: obj })
          end

          # def supports(support)
          #   language.set(:values, registry_key => support)
          # end

          def matrix(key, opts = {})
            opts = opts.merge(only: { language: registry_key })
            opts[:to] ||= :seq
            super
          end

          def map(key, opts = {})
            opts = opts.merge(only: { language: registry_key })
            super
          end

          def language
            root.node.mappings[:language]
          end
        end
      end
    end
  end
end
