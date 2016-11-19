module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Surge < Deploy
            register :surge

            def define
              super
              map :project, to: :scalar
              map :domain,  to: :scalar
            end
          end
        end
      end
    end
  end
end
