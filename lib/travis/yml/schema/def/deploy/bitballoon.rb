# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention bitballoon
          class Bitballoon < Deploy
            register :bitballoon

            def define
              map :access_token, to: :secure
              map :site_id,      to: :secure
              map :local_dir,    to: :str
            end
          end
        end
      end
    end
  end
end
