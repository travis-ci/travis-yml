require 'travis/config'

module Travis
  module Yaml
    class Web
      class Config < Travis::Config
        define auth_keys: ['abc123']
      end
    end
  end
end
