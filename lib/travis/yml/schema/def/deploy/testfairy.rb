# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention notify
          # docs do not mention max-duration
          # docs do not mention record-on-background
          class Testfairy < Deploy
            register :testfairy

            def define
              map :api_key,              to: :secure
              map :app_file,             to: :str
              map :symbols_file,         to: :str
              map :testers_groups,       to: :str
              map :notify,               to: :bool
              map :auto_update,          to: :bool
              map :advanced_options,     to: :str
            end
          end
        end
      end
    end
  end
end
