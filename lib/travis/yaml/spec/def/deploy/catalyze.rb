module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention catalyze
          class Catalyze < Deploy
            register :catalyze

            def define
              super
              map :target, to: :scalar
              map :path,   to: :scalar
            end
          end
        end
      end
    end
  end
end
