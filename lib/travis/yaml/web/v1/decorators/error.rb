module Travis::Yaml::Web::V1
  module Decorators
    class Error
      def initialize(error)
        @error = error
      end

      def call
        {
          'version'.freeze => 'v1',
          'error_type'.freeze => name,
          'error_message'.freeze => @error.message,
        }
      end

      private

      def name
        name = @error.class.name.split('::'.freeze).last
        name.gsub(/([A-Z])([A-Z])/, '\1_\2'.freeze).gsub(/([a-z])([A-Z])/, '\1_\2'.freeze).downcase
      end
    end
  end
end
