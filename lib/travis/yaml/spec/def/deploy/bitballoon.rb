module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention bitballoon
          class Bitballoon < Deploy
            register :bitballoon

            def define
              super
              map :access_token, to: :scalar, cast: :secure
              map :site_id,      to: :scalar
              map :local_dir,    to: :scalar
            end
          end
        end
      end
    end
  end
end
