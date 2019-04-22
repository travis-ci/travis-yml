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

          def aliases(*aliases)
            language.set(:values, registry_key => { aliases: to_strs(aliases) })
          end

          def deprecated(obj)
            language.set(:values, registry_key => { deprecated: obj })
          end

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
            node.mappings[:language]
          end
        end
      end
    end
  end
end
