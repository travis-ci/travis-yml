module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention notify
          # docs do not mention max-duration
          # docs do not mention record-on-background
          class Testfairy < Deploy
            register :testfairy

            def define
              super
              map :api_key,             to: :scalar, cast: :secure, alias: :'api-key'
              map :app_file,            to: :scalar, alias: :'app-file'
              map :symbols_file,        to: :scalar, alias: :'symbols-file'
              map :keystore_file,       to: :scalar, alias: :'keystore-file'
              map :storepass,           to: :scalar
              map :alias,               to: :scalar
              map :testers_groups,      to: :scalar, alias: :'testers-groups'
              map :notify,              to: :scalar, cast: :bool
              map :auto_update,         to: :scalar, cast: :bool, alias: :'auto-update'
              map :video_quality,       to: :scalar, alias: :'video-quality'
              map :screenshot_quality,  to: :scalar, alias: :'screenshot-quality'
              map :screenshot_interval, to: :scalar, alias: :'screenshot-interval'
              map :max_duration,        to: :scalar, alias: :'max-duration'
              map :advanced_options,    to: :scalar, alias: :'advanced-options'
              map :data_only_wifi,      to: :scalar, cast: :bool, alias: :'data-only-wifi'
              map :record_on_backgroup, to: :scalar, cast: :bool, alias: :'record-on-backgroup'
              map :video,               to: :scalar, cast: :bool
              map :icon_watermark,      to: :scalar, cast: :bool, alias: :'icon-watermark'
              map :metrics,             to: :scalar
            end
          end
        end
      end
    end
  end
end
