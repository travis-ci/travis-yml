module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # dpl readme says it's local_dir, docs say it's local-dir
          # dpl readme does not mention package_glob
          class Packagecloud < Deploy
            register :packagecloud

            def define
              super
              map :username,     to: :scalar, cast: :secure
              map :token,        to: :scalar, cast: :secure
              map :repository,   to: :scalar
              map :local_dir,    to: :scalar, alias: %i(local-dir)
              map :dist,         to: :scalar
              map :package_glob, to: :scalar
            end
          end
        end
      end
    end
  end
end
