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
              super
              map :user_id,           to: :secure
              map :client_key,        to: :secure
              map :cookbook_category, to: :str

              export
            end
          end
        end
      end
    end
  end
end
