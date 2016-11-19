module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class SauceConnect < Type::Map
            register :sauce_connect

            def define
              normalize :enabled

              map :enabled,             to: :scalar, cast: :bool
              map :username,            to: :scalar, cast: :secure
              map :access_key,          to: :scalar, cast: :secure
              map :direct_domains,      to: :scalar
              map :tunnel_domains,      to: :scalar
              map :no_ssl_bump_domains, to: :scalar
            end
          end
        end
      end
    end
  end
end
