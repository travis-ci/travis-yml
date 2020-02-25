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
        rescue Yml::Error, Oj::Error, EncodingError => e
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
            opts = opts.merge(token: token, internal: internal?)
            opts
          end

          def token
            match_auth(/token (.+)/)
          end

          def internal?
            return false unless auth
            match_auth(/internal:(.+)/) == config[:auth][:internal]
          end

          def match_auth(pattern)
            auth.to_s =~ pattern && $1
          end

          def auth
            request_headers[:authorization]
          end

          def data
            Oj.load(request_body, symbol_keys: true, mode: :strict, empty_string: false)
          end

          def config
            Web.config
          end
      end
    end
  end
end
