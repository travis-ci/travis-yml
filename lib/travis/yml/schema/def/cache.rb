# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Cache < Type::Any
          register :cache

          TYPES = %i(apt bundler cargo ccache cocoapods npm packages pip yarn)

          def define
            summary 'Cache settings to speed up the build'

            type Class.new(Type::Map) {
              def define
                normal

                map :directories, to: :seq, eg: './path'

                TYPES.each do |type|
                  map type, to: :bool
                end

                map :edge,    to: :bool, summary: 'Whether to use an edge version of the cache tooling'
                map :timeout, to: :num
                map :branch,  to: :str # not documented?

                # prefix :directories
                change :cache
              end
            }

            type :bool, values: [false], normal: true

            export
          end
        end
      end
    end
  end
end
