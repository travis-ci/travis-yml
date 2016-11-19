module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention puppetforge
          class Puppetforge < Deploy
            register :puppetforge

            def define
              super
              map :user,     to: :scalar, required: true, cast: :secure
              map :password, to: :scalar, required: true, cast: :secure
              map :url,      to: :scalar
            end
          end
        end
      end
    end
  end
end
