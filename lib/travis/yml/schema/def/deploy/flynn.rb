# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Flynn < Deploy
            register :flynn

            def define
              map :git, to: :secure, strict: false
            end
          end
        end
      end
    end
  end
end
