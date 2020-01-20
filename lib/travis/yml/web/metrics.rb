require 'travis/metrics'

module Travis
  module Yml
    module Web
      class Metrics < Sinatra::Base
        def call(env)
          time(env) { super }
        end

        private

          def time(env, &block)
            metrics ? metrics.time(key(env), &block) : yield
          end

          def key(env)
            key = case path(env)
            when %r(^(v1/)?/expand$) then :expand
            when %r(^(v1/)?/parse$) then :parse
            when %r(^(/css/*|favicon.ico)$) then :static
            else get?(env) ? :docs : :unknown_request
            end
            ['yml', key].join('.')
          end

          def get?(env)
            env['REQUEST_METHOD'] == 'GET'
          end

          def path(env)
            env['PATH_INFO'].chomp(?/)
          end

          def metrics
            Web.metrics
          end
      end
    end
  end
end
