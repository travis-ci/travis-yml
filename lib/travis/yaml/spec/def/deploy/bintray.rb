module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Bintray < Deploy
            register :bintray

            def define
              super
              map :file,       to: :str
              map :user,       to: :str, secure: true
              map :key,        to: :str, secure: true
              map :passphrase, to: :str, secure: true
              map :dry_run,    to: :bool
            end
          end
        end
      end
    end
  end
end
