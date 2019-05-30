# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Browserstack < Addon
            register :browserstack

            def define
              map :username,   to: :secure, strict: false, summary: 'Browserstack username'
              map :access_key, to: :secure, summary: 'Browserstack access key'
              map :forcelocal, to: :bool, summary: 'Force all network traffic to be resolved via the build environment VM'
              map :only,       to: :str, summary: 'Restrict local testing access to the specified local servers/directories'
              map :app_path,   to: :str, summary: 'Path to the app file'

              # TODO alias these to underscored options
              map :proxyHost,  to: :str
              map :proxyPort,  to: :str
              map :proxyUser,  to: :str
              map :proxyPass,  to: :secure

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
            end
          end
        end
      end
    end
  end
end
