# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Cache < Type::Any
          register :cache

          TYPES = %i(apt bundler cargo ccache cocoapods npm packages pip shards yarn)

          def define
            summary 'Cache settings to speed up the build'

            description <<~str
              Activates caching content that does not often change in order to speed up the build process.

              There are built-in caching strategies for #{TYPES.map { |type| "`#{type}`" }.join(', ')}.
              For other scenarios the generic `directory` option can be used.
            str

            see 'Caching Dependencies and Directories': 'https://docs.travis-ci.com/user/caching/'

            type Class.new(Type::Map) {
              def define
                normal

                map :directories, to: :strs, summary: 'Generic directory caching strategy', eg: './path'

                TYPES.each do |type|
                  map type, to: :bool, summary: "Use the #{type} caching strategy"
                end

                map :timeout,     to: :num,  summary: 'Timeout for the cache tooling'
                map :edge,        to: :bool, summary: 'Use an edge version of the cache tooling'
                map :branch,      to: :str

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
