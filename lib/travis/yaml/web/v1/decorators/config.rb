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
          'version'.freeze => 'v1',
          'messages'.freeze => messages,
          'full_messages'.freeze => full_messages,
          'config'.freeze => result
        }
      end

      private

      def messages
        @config.msgs.map do |level, key, code, args|
          {
            'level'.freeze => level,
            'key'.freeze => key,
            'code'.freeze => code,
            'args'.freeze => args
          }
        end
      end

      def full_messages
        @config.msgs.map { |m| Travis::Yaml.msg(m) }
      end
    end
  end
end
