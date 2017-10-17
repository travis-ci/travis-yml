require 'travis/yaml/web/config'

module Travis::Yaml::Web::V1
  module Routes
    module Route
      def call(env)
        return not_authenticated unless authenticated?(env)
        public_send(env['REQUEST_METHOD'.freeze].downcase, env)
      end

      private

      def config
        @config ||= Travis::Yaml::Web::Config.load
      end

      def method_missing(*)
        [404, {}, []]
      end

      def authenticated?(env)
        auth = Rack::Auth::Basic::Request.new(env)
        return false unless auth.provided? && auth.basic? && auth.credentials
        config.auth_keys.any? { |key| Rack::Utils.secure_compare(key, auth.credentials.last) }
      end

      def not_authenticated
        [401, { 'WWW-Authenticate'.freeze => 'Basic realm="Restricted area"'.freeze }, []]
      end
    end
  end
end
