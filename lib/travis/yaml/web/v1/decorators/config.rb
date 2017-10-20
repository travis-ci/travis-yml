require 'travis/yaml'

module Travis::Yaml::Web::V1
  module Decorators
    class Config
      def initialize(config)
        @config = config
      end

      def call
        result = @config.serialize
        {
          'version' => 'v1',
          'messages' => @config.msgs.map { |m| Travis::Yaml.msg(m) },
          'config' => result,
          'matrix' => Travis::Yaml.matrix(result).rows
        }
      end
    end
  end
end
