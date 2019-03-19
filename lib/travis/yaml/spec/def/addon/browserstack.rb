# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Browserstack < Type::Map
            register :browserstack

            def define
              map :username,     to: :str, cast: :str
              map :access_key,   to: :str, secure: true
              map :forcelocal,   to: :bool
              map :only,         to: :str

              # TODO ugh, mixing snakecase and camelcase? underscore these.
              map :proxyHost,    to: :str
              map :proxyPort,    to: :str
              map :proxyUser,    to: :str
              map :proxyPass,    to: :str, secure: true

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
