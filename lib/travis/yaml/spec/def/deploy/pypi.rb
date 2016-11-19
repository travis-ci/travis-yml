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
              map :user,          to: :str, secure: true
              map :password,      to: :str, secure: true
              map :api_key,       to: :str, secure: true
              map :server,        to: :str
              map :distributions, to: :str
              map :docs_dir,      to: :str
            end
          end
        end
      end
    end
  end
end
