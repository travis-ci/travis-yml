# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Surge < Deploy
            register :surge

            def define
              super
              map :project, to: :str
              map :domain,  to: :str
            end
          end
        end
      end
    end
  end
end
