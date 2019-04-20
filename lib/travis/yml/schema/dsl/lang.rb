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

          def define
            Def::Lang.values(registry_key => {})
          end

          def aliases(*aliases)
            Def::Lang.values(registry_key => { aliases: to_syms(aliases) })
          end

          def deprecated(*)
            Def::Lang.values(registry_key => { deprecated: true })
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
        end
      end
    end
  end
end
