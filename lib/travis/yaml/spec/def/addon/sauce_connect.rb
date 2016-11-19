module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class SauceConnect < Type::Map
            register :sauce_connect

            def define
              change :enable

              map :enabled,             to: :bool # TODO what is this useful for?
              map :username,            to: :str, secure: true
              map :access_key,          to: :str, secure: true
              map :direct_domains,      to: :str
              map :tunnel_domains,      to: :str
              map :no_ssl_bump_domains, to: :str
            end
          end
        end
      end
    end
  end
end
