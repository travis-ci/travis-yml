# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Cache < Type::Map
          register :cache

          TYPES = %i(apt bundler cargo ccache cocoapods npm packages pip yarn)

          def define
            summary 'Cache settings to speed up the build'

            normal

            TYPES.each do |type|
              map type, to: :bool
            end

            map :edge,        to: :bool, edge: true, summary: 'Whether to use an edge version of the cache tooling'
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
