module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Script < Deploy
            register :script

            def define
              super
              map :script, to: :str # TODO should be a seq?
            end
          end
        end
      end
    end
  end
end
