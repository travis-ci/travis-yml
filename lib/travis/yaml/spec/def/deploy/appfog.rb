module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # dpl readme does not mention address
          # dpl readme does not mention metadata
          # dpl readme does not mention email
          # dpl readme does not mention api_key
          # dpl readme does not mention after_deploy
          class Appfog < Deploy
            register :appfog

            def define
              super
              map :user,         to: [:scalar, :map], cast: :secure
              map :password,     to: [:scalar, :map], cast: :secure
              map :email,        to: [:scalar, :map], cast: :secure
              map :api_key,      to: [:scalar, :map], cast: :secure
              map :app,          to: [:scalar, :map]
              map :address,      to: :seq
              map :metadata,     to: :scalar
              map :after_deploy, to: :seq
            end
          end
        end
      end
    end
  end
end
