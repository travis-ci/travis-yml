# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # dpl readme does not mention address
          # dpl readme does not mention metadata
          # dpl readme does not mention email
          # dpl readme does not mention api_key
          # dpl readme does not mention after_deploy
          # docs do not mention user
          # docs do not mention api_key
          # docs do not mention metadata
          class Appfog < Deploy
            register :appfog

            def define
              map :user,         to: :secure
              map :api_key,      to: :secure
              map :address,      to: :seq
              map :metadata,     to: :str
              map :after_deploy, to: :seq
              map :app,          to: :map, type: :str

              # extract to :secure_map?
              type = Class.new(Dsl::Any) do
                def define
                  add Class.new(Dsl::Map) {
                    def define
                      strict false
                      map '.*', to: :secure
                    end
                  }
                  add :secure
                end
              end

              map :email, to: type
              map :password, to: type
            end
          end
        end
      end
    end
  end
end
