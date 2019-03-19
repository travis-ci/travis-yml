# frozen_string_literal: true
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
              map :user_id,           to: :str, secure: true
              map :client_key,        to: :str, secure: true
              map :cookbook_category, to: :str
            end
          end
        end
      end
    end
  end
end
