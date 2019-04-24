# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Divshot < Deploy
            register :divshot

            def define
              map :api_key,     to: :secure
              map :environment, to: :str
            end
          end
        end
      end
    end
  end
end
