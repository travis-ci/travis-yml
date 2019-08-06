# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Netlify < Deploy
            register :netlify

            def define
              map :site,      to: :str
              map :auth,      to: :secure
              map :dir,       to: :str
              map :functions, to: :str
              map :message,   to: :str
              map :prod,      to: :bool
            end
          end
        end
      end
    end
  end
end
