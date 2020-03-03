require 'raven'

module Travis
  module Yml
    module Web
      class Sentry < Sinatra::Base
        configure do
          Raven.configure do |config|
            config.processors -= [Raven::Processor::PostData] # send POST data
          end
          use Raven::Rack
        end
      end
    end
  end
end
