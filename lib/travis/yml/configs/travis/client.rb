require 'faraday'
require 'faraday_middleware'
require 'travis/yml/configs/travis/error'
require 'travis/yml/helper/instrument'
require 'travis/yml/helper/metrics'
require 'travis/yml/helper/obj'

module Travis
  module Yml
    module Configs
      module Travis
        class Client < Struct.new(:opts)
          include Helper::Metrics, Helper::Obj, Yml::Instrument

          HEADERS  = {
            'User-Agent': 'Travis-CI-Yml/Faraday',
            'Travis-API-Version': '3',
          }

          RETRY = {
            max: 8,
            interval: 0.05,
            interval_randomness: 0.5,
            backoff_factor: 2,
            retry_statuses: [500, 502, 503, 504]
          }

          def get(path, params = {})
            client.get(path, params)
          rescue Faraday::Error => e
            raise error(:get, path, e)
          end
          time :get, key: 'travis.get'
          instrument :get

          def client
            Faraday.new(url: url, headers: HEADERS, ssl: ssl) do |c|
              c.use FaradayMiddleware::FollowRedirects
              c.request :authorization, *auth
              c.request :retry, RETRY.merge(retry_block: method(:on_retry))
              c.response :raise_error
              c.adapter :net_http
              # c.response :logger
            end
          end

          def on_retry(env, opts, retries, e)
            # [:method, :url, :request, :request_headers, :ssl]
            logger.info "env: #{env}, status: #{e.inspect}. Retrying (#{retries}/8) ..."
          end

          def url
            config[:travis][:url]
          end

          def ssl
            compact(config[:ssl].to_h.merge(config[:travis][:ssl] || {}))
          end

          def auth
            [:internal, "#{config[:travis][:app]}:#{config[:travis][:token]}"]
          end

          def error(method, path, e)
            msg = e.response && e.response[:body] if e.response
            msg = Oj.parse(msg)['error_message'] rescue msg
            Error.new(method, path, e.response[:status], msg)
          end

          def config
            Yml.config
          end

          def logger
            Yml.logger
          end
        end
      end
    end
  end
end
