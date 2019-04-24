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
              map :'access-token', to: :secure
              map :'site-id',      to: :secure
              map :'local-dir',    to: :str
            end
          end
        end
      end
    end
  end
end
