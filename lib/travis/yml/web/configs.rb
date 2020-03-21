require 'oj'
require 'travis/yml/web/helpers'

module Travis
  module Yml
    module Web
      class Configs < Sinatra::Base
        include Helpers

        before '/configs' do
          halt 401 unless internal?
        end

        post '/configs' do
          status 200
          json configs.to_h
        rescue Yml::Error, Oj::Error, EncodingError => e
          error e
        end

        private

          def configs
            Travis::Yml.configs(*args, opts).tap(&:load)
          end

          def args
            args = data.values_at(:repo, :ref, :configs, :data)
            args[2] ||= [only(data, :config, :mode)] if data[:config] # BC
            args
          end

          def opts
            keys = OPTS.keys.map(&:to_s) & params.keys
            opts = symbolize(keys.map { |key| [key, params[key.to_s] == 'true'] }.to_h)
            opts
          end

          def internal?
            auth = auth_header =~ /internal (.+)/ && $1
            auth == config[:auth][:internal]
          end

          def auth_header
            request_headers[:authorization].to_s
          end

          def data
            Oj.load(request_body, symbol_keys: true, mode: :strict, empty_string: false)
          end

          def only(hash, *keys)
            hash.select { |key, _| keys.include?(key) }
          end

          def config
            Web.config
          end
      end
    end
  end
end
