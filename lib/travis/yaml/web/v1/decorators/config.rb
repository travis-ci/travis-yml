require 'travis/yaml'

module Travis::Yaml::Web::V1
  module Decorators
    class Config
      def initialize(config)
        @config = config
      end

      def decorate
        {
          'version' => 'v1',
          'messages' => @config.msgs.map { |m| Travis::Yaml.msg(m) },
          'config' => @config.serialize
        }
      end
    end
  end
end
