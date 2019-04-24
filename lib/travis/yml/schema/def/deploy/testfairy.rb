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
              map :api_key,             to: :secure
              map :app_file,            to: :str
              map :symbols_file,        to: :str
              map :testers_groups,      to: :str
              map :notify,              to: :bool
              map :auto_update,         to: :bool
              map :video_quality,       to: :str
              map :screenshot_quality,  to: :str
              map :screenshot_interval, to: :str
              map :max_duration,        to: :str
              map :advanced_options,    to: :str
              map :data_only_wifi,      to: :bool
              map :record_on_backgroup, to: :bool
              map :video,               to: :bool
              map :icon_watermark,      to: :bool
              map :metrics,             to: :str
            end
          end
        end
      end
    end
  end
end
