# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Cargo < Deploy
            register :cargo

            def define
              map :token, to: :secure
            end
          end
        end
      end
    end
  end
end
