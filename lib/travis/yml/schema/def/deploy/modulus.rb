# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Modulus < Deploy
            register :modulus

            def define
              super
              map :api_key,      to: :secure
              map :project_name, to: :str

              export
            end
          end
        end
      end
    end
  end
end
