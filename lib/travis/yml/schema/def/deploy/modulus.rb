# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Modulus < Deploy
            register :modulus

            def define
              map :api_key,      to: :secure
              map :project_name, to: :str
            end
          end
        end
      end
    end
  end
end
