module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention chef-supermarket
          class ChefSupermarket < Deploy
            register :chef_supermarket

            def define
              super
              map :user_id,           to: :scalar, cast: :secure
              map :client_key,        to: :scalar, cast: :secure
              map :cookbook_category, to: :scalar
            end
          end
        end
      end
    end
  end
end
