# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        class Cache < Dsl::Map
          register :cache

          TYPES = %i(apt bundler cargo ccache cocoapods npm packages pip yarn)

          # desc edge: 'Whether to use an edge version of the cache tooling'

          def define
            normal

            TYPES.each do |type|
              map type, to: :bool
            end

            map :edge,        to: :bool, edge: true
            map :directories, to: :seq
            map :timeout,     to: :num
            map :branch,      to: :str

            prefix :directories
            change :cache

            export
          end
        end
      end
    end
  end
end
