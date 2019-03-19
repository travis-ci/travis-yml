# frozen_string_literal: true
require 'travis/config'

module Travis::Yaml::Web
  class Config < Travis::Config
    define auth_keys: ['abc123']
  end
end
