# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Browserstack < Addon
            register :browserstack

            def define
              map :username,     to: :secure
              map :access_key,   to: :secure
              map :forcelocal,   to: :bool
              map :only,         to: :str
              map :app_path,     to: :str
              map :proxyHost,    to: :str
              map :proxyPort,    to: :str
              map :proxyUser,    to: :str
              map :proxyPass,    to: :secure

              # TODO from travis-build
              #
              # [:access_key] || config[:accessKey]
              # [:verbose] || config[:v]
              # [:force]
              # [:only]
              # [:local_identifier] || config[:localIdentifier]).to_s
              # [:folder] || config[:f]
              # [:force_local] || config[:forcelocal]
              # [:only_automate] || config[:onlyAutomate]
              # [:proxy_host] || config[:proxyHost]
              # [:proxy_port] || config[:proxyPort]
              # [:proxy_user] || config[:proxyUser]
              # [:proxy_pass] || config[:proxyPass]

              super
            end
          end
        end
      end
    end
  end
end
