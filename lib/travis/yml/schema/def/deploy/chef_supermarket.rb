# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention chef-supermarket
          class ChefSupermarket < Deploy
            register :chef_supermarket

            def define
              map :user_id,    to: :secure
              map :client_key, to: :secure
              map :name,       to: :str, alias: :cookbook_name
              map :category,   to: :str, alias: :cookbook_category
              map :dir,        to: :str
            end
          end
        end
      end
    end
  end
end
