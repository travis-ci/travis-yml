# frozen_string_literal: true
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
              map :target, to: :str
              map :path,   to: :str
            end
          end
        end
      end
    end
  end
end
