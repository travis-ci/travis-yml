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

          def get(path, opts = {})
            client.get(path, opts)
          rescue Faraday::Error => e
            raise error(:get, path, e)
          end
          time :get, key: 'github.get'

          def client
            Faraday.new(url: url, headers: HEADERS, ssl: ssl) do |c|
              c.use FaradayMiddleware::FollowRedirects
              c.request :authorization, :token, token if token
              c.request :retry
              c.response :raise_error
              # c.response :logger
              c.adapter :net_http
            end
          end

          def url
            config[:github][:url]
          end

          def ssl
            compact(config[:ssl].to_h.merge(config[:github][:ssl] || {}))
          end

          def config
            Yml.config
          end

          def error(method, path, e)
            Error.new(method, path, e.response[:status], e.response[:body])
          end
        end
      end
    end
  end
end
