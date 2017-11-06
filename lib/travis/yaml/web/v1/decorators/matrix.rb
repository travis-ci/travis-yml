require 'travis/yaml'

module Travis::Yaml::Web::V1
  module Decorators
    class Matrix
      def initialize(config)
        @config = config
      end

      def call
        {
          'version'.freeze => 'v1',
          'matrix'.freeze => Travis::Yaml.matrix(@config).rows
        }
      end
    end
  end
end
