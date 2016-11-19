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
              map :access_token, to: :str, secure: true
              map :site_id,      to: :str
              map :local_dir,    to: :str
            end
          end
        end
      end
    end
  end
end
