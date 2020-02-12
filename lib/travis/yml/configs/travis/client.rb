require 'faraday_middleware'
require 'travis/yml/configs/travis/error'
require 'travis/yml/helper/instrument'
require 'travis/yml/helper/obj'

module Travis
  module Yml
    module Configs
      module Travis
        class Client
          include Helper::Obj, Yml::Instrument

          HEADERS  = {
            'User-Agent': 'Travis-CI-Yml/Faraday',
            'Travis-API-Version': '3',
          }

          def get(path, opts = {})
            client.get(path, opts)
          rescue Faraday::Error => e
            raise error(:get, path, e)
          end
          instrument :get

          def client
            Faraday.new(url: url, headers: HEADERS, ssl: ssl) do |c|
              c.use FaradayMiddleware::FollowRedirects
              c.request  :authorization, :internal, "admin:#{token}" if token
              c.request  :retry
              c.response :raise_error
              # c.response :logger
              c.adapter  :net_http
            end
          end

          def url
            config[:travis][:url]
          end

          def ssl
            compact(config[:ssl].to_h.merge(config[:travis][:ssl] || {}))
          end

          def token
            config[:travis][:token]
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
