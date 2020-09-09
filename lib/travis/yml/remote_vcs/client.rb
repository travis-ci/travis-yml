require 'faraday'
require 'faraday_middleware'

module Travis
  module Yml
    module RemoteVcs
      class Client
        private

          def connection
            @connection ||= Faraday.new(http_options.merge(url: config[:vcs][:url])) do |c|
              c.request :authorization, :token, config[:vcs][:token]
              c.request :retry, max: 5, interval: 0.1, backoff_factor: 2
              c.request :json
              c.use Faraday::Response::RaiseError
              c.use Faraday::Adapter::NetHttp
            end
          end

          def http_options
            { ssl: config[:ssl].to_h }
          end

          def request(method, name)
            resp = connection.send(method) { |req| yield(req) }
            logger.info("RemoteVcs response #{resp.inspect}")
            JSON.parse(resp.body)
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
