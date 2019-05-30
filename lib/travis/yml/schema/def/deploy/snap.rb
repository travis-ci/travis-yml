# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Snap < Deploy
            register :snap

            def define
              map :snap,         to: :str
              map :channel,      to: :str
              map :skip_cleanup, to: :bool
              map :token,        to: :secure
            end
          end
        end
      end
    end
  end
end
