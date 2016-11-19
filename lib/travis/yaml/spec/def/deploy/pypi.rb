module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention docs_dir
          class Pypi < Deploy
            register :pypi

            def define
              super
              map :user,          to: :scalar, cast: :secure
              map :password,      to: :scalar, cast: :secure
              map :api_key,       to: :scalar, cast: :secure
              map :server,        to: :scalar
              map :distributions, to: :scalar
              map :docs_dir,      to: :scalar
            end
          end
        end
      end
    end
  end
end
