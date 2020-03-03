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
              map :allow_dirty, to: :bool
            end
          end
        end
      end
    end
  end
end
