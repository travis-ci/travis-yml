require 'oj'
require 'travis/yml/web/helpers'
require 'logger'

module Travis
  module Yml
    module Web
      class Expand < Sinatra::Base
        include Helpers

        post '/expand' do
          handle
        end

        post '/v1/expand' do
          handle
        end

        private

          def handle
            logger = Logger.new('/tmp/3.log')
            logger.info("Body: #{request_body}")
            logger.info("Response: #{expand}")
            status 200
            json matrix: expand
          rescue Oj::Error, EncodingError => e
            status 400
            error(e)
          end

          def expand
            Travis::Yml.matrix(data).rows
          end

          def data
            Oj.load(request_body, symbol_keys: true, mode: :strict, empty_string: false)
          end

          def request_body
            request.body.read.tap { request.body.rewind }
          end
      end
    end
  end
end
