module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Divshot < Deploy
            register :divshot

            def define
              super
              map :api_key,     to: :str, secure: true
              map :environment, to: :str
            end
          end
        end
      end
    end
  end
end
