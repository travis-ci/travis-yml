# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # dpl readme says it's local_dir, docs say it's local-dir
          # dpl readme does not mention package_glob
          class Packagecloud < Deploy
            register :packagecloud

            def define
              map :username,     to: :secure, strict: false
              map :token,        to: :secure
              map :repository,   to: :str
              map :local_dir,    to: :str
              map :dist,         to: :str
              map :package_glob, to: :str
              map :force,        to: :bool
            end
          end
        end
      end
    end
  end
end
