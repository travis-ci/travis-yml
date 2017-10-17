module Travis::Yaml::Web::V1
  module Routes
    module Route
      def call(env)
        public_send(env['REQUEST_METHOD'.freeze].downcase, env)
      end

      private

      def method_missing(*)
        [404, {}, []]
      end
    end
  end
end
