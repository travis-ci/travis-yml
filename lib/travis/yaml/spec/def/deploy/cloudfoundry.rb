module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # dpl readme does not mention key
          # docs do not mention manifest
          # docs do not mention skip_ssl_validation
          class Cloudfoundry < Deploy
            register :cloudfoundry

            def define
              super
              map :username,            to: :scalar, cast: :secure
              map :password,            to: :scalar, cast: :secure
              map :organization,        to: :scalar
              map :api,                 to: :scalar
              map :space,               to: :scalar
              map :key,                 to: :scalar
              map :manifest,            to: :scalar
              map :skip_ssl_validation, to: :scalar, cast: :bool
            end
          end
        end
      end
    end
  end
end
