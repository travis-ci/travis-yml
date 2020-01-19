# frozen_string_literal: true
require 'travis/config'

module Travis::Yml::Web
  class Config < Travis::Config
    define auth_keys:  ['abc123'],
           enterprise: ENV['TRAVIS_ENTERPRISE'] || false,
           metrics:    { reporter: 'librato' }
  end
end
