# frozen_string_literal: true

module Travis
  module Yml
    module Web
      class Auth
        attr_reader :app, :keys

        def initialize(app, keys)
          @app = app
          @keys = keys
        end

        def call(env)
          return not_authenticated unless get?(env) || authenticated?(env)
          app.call(env)
        end

        private

        def get?(env)
          env['REQUEST_METHOD'] == 'GET'
        end

        def authenticated?(env)
          auth = Rack::Auth::Basic::Request.new(env)
          return false unless auth.provided? && auth.basic? && auth.credentials
          keys.any? { |key| Rack::Utils.secure_compare(key, auth.credentials.last) }
        end

        def not_authenticated
          [401, { 'WWW-Authenticate' => 'Basic realm="Restricted area"' }, []]
        end
      end
    end
  end
end
