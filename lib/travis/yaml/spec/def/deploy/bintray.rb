module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Bintray < Deploy
            register :bintray

            def define
              super
              map :file,       to: :scalar
              map :user,       to: :scalar, cast: :secure
              map :key,        to: :scalar
              map :passphrase, to: :scalar, cast: :secure
              map :dry_run,    to: :scalar, cast: :bool, alias: :'dry-run'
            end
          end
        end
      end
    end
  end
end
