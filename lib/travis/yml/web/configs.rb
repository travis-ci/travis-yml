require 'oj'
require 'travis/yml/web/helpers'

module Travis
  module Yml
    module Web
      class Configs < Sinatra::Base
        include Helpers

        post '/configs' do
          status 200
          json configs.to_h
        rescue Yml::Error => e
          raise if e.internal?
          status 400
          error(e)
        end

        private

          def configs
            Travis::Yml.configs(*args, opts).tap(&:load)
          end

          def args
            data.values_at(:repo, :ref, :config, :mode, :data)
          end

          def opts
            keys = OPTS.keys.map(&:to_s) & params.keys
            opts = symbolize(keys.map { |key| [key, params[key.to_s] == 'true'] }.to_h)
            # TODO merge in tokens from headers
            opts
          end

          def data
            Oj.load(request_body, symbol_keys: true, mode: :strict, empty_string: false)
          end

          def request_body
            request.body.read.tap { request.body.rewind }
          end

          def symbolize(hash)
            hash.map { |key, value| [key.to_sym, value] }.to_h
          end
      end
    end
  end
end
