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

          def get(path, params = {})
            client.get(path, params)
          rescue Error, Faraday::Error => e
            raise error(:get, path, e)
          end
          time :get, key: 'travis.get'
          instrument :get

          def client
            Faraday.new(url: url, headers: HEADERS, ssl: ssl) do |c|
              c.use FaradayMiddleware::FollowRedirects
              c.request  :authorization, *auth
              c.request  :retry
              c.response :raise_error
              c.adapter  :net_http
              # c.response :logger
            end
          end

          def url
            config[:travis][:url]
          end

          def ssl
            compact(config[:ssl].to_h.merge(config[:travis][:ssl] || {}))
          end

          def auth
            auth = opts[:auth] || raise('no auth provided')
            opts[:auth]&.to_a&.flatten
          end

          def error(method, path, e)
            msg = e.response[:body]
            msg = Oj.parse(msg)['error_message'] rescue msg
            Error.new(method, path, e.response[:status], msg)
          end

          def config
            Yml.config
          end
        end
      end
    end
  end
end
