# frozen_string_literal: true
require 'travis/yaml/web/config'

module Travis::Yaml::Web
  class BasicAuth
    def initialize(app)
      @app = app
    end

    def call(env)
      return not_authenticated unless authenticated?(env)
      @app.call(env)
    end

    private

    def config
      @config ||= Travis::Yaml::Web::Config.load
    end

    def authenticated?(env)
      auth = Rack::Auth::Basic::Request.new(env)
      return false unless auth.provided? && auth.basic? && auth.credentials
      config.auth_keys.any? { |key| Rack::Utils.secure_compare(key, auth.credentials.last) }
    end

    def not_authenticated
      [401, { 'WWW-Authenticate' => 'Basic realm="Restricted area"' }, []]
    end
  end
end
