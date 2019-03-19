# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Modulus < Deploy
            register :modulus

            def define
              super
              map :api_key,      to: :str, secure: true
              map :project_name, to: :str
            end
          end
        end
      end
    end
  end
end
