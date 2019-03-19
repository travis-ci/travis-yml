# frozen_string_literal: true
module Travis::Yaml::Web::V1
  module Decorators
    class Error
      def initialize(error)
        @error = error
      end

      def call
        {
          'version' => 'v1',
          'error_type' => name,
          'error_message' => @error.message,
        }
      end

      private

      def name
        name = @error.class.name.split('::').last
        name.gsub(/([A-Z])([A-Z])/, '\1_\2').gsub(/([a-z])([A-Z])/, '\1_\2').downcase
      end
    end
  end
end
