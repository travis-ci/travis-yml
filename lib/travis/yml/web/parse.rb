# frozen_string_literal: true

require 'oj'
require 'travis/yml/web/helpers'
require 'logger'

module Travis
  module Yml
    module Web
      class Parse < Sinatra::Base
        include Helpers

        MIME_TYPE = 'application/vnd.travis-ci.configs+json'

        post '/parse' do
          handle
        end

        post '/v1/parse' do
          handle
        end

        private

          def handle
            logger = Logger.new('/tmp/2.log')
            logger.info("Request body: #{request_body}")
            logger.info("Response: #{Parse::Config.new(load).to_h}")
            status 200
            json Parse::Config.new(load).to_h
          rescue Yml::InputError => e
            status 400
            error(e)
          end

          def load
            Travis::Yml.load(configs? ? configs : [config], opts)
          end

          def configs?
            env['CONTENT_TYPE'] == MIME_TYPE
          end

          def config
            Parts::Part.new(request_body)
          end

          def configs
            Oj.load(request_body).map do |part|
              config, source, mode = part.values_at(*%w(config source merge_mode))
              key = source == 'api' ? :rgt : :lft
              Parts::Part.new(config, source, key => mode)
            end
          end

          def opts
            keys = OPTS.keys.map(&:to_s) & params.keys
            symbolize(keys.map { |key| [key, params[key.to_s] == 'true'] }.to_h)
          end

          def symbolize(hash)
            hash.map { |key, value| [key.to_sym, value] }.to_h
          end
      end
    end
  end
end

require 'travis/yml/web/parse/config'
