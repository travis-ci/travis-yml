require 'faraday_middleware'
require 'travis/yml/configs/github/error'
require 'travis/yml/helper/metrics'
require 'travis/yml/helper/obj'

module Travis
  module Yml
    module Configs
      module Github
        class Client < Struct.new(:token)
          include Helper::Metrics, Helper::Obj

          HEADERS  = {
            'User-Agent': 'Travis-CI-Yml/Faraday',
            'Accept': 'application/vnd.github.v3+json',
            'Accept-Charset': 'utf-8'
          }

          RETRY = {
            max: 8,
            interval: 0.05,
            interval_randomness: 0.5,
            backoff_factor: 2,
            retry_statuses: [500, 502, 503, 504]
          }

          def get(path, params = {})
            client.get(path, params.merge(oauth))
          rescue Faraday::Error => e
            raise error(:get, path, e)
          end
          time :get, key: 'github.get'

          def client
            Faraday.new(url: url, headers: HEADERS, ssl: ssl) do |c|
              c.use FaradayMiddleware::FollowRedirects
              c.request :authorization, :token, token if token
              c.request :retry, RETRY.merge(retry_block: method(:on_retry))
              c.response :raise_error
              # c.response :logger
              c.adapter :net_http
            end
          end

          def on_retry(env, opts, retries, e)
            p [:on_retry, env.keys]
            logger.info "Status: #{e.response[:status]}. Retrying (#{retries}/8) ..."
          end

          def url
            config[:github][:url]
          end

          def oauth
            compact(only(config.oauth2.to_h, :client_id, :client_secret))
          end

          def ssl
            compact(config[:ssl].to_h.merge(config[:github][:ssl] || {}))
          end

          def config
            Yml.config
          end

          def logger
            Yml.logger
          end

          def error(method, path, e)
            Error.new(method, path, e.response[:status], e.response[:body])
          end
        end
      end
    end
  end
end
