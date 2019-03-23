# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # dpl readme says it's api-key, our docs say it's api_key
          class Engineyard < Deploy
            register :engineyard

            def define
              super
              map :username,    to: :secure
              map :password,    to: :secure
              map :api_key,     to: :secure
              map :app,         to: :str
              # TODO where is this env evaluated?
              map :environment, to: :str
              map :migrate,     to: :str

              export
            end
          end
        end
      end
    end
  end
end
