describe Travis::Yaml::Spec::Def::Deploy::Testfairy do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :testfairy,
      type: :map,
      strict: false,
      prefix: {
        key: :provider,
        type: :scalar
      }
    )
  end

  it do
    expect(except(spec[:map], :provider, :on, :skip_cleanup, :edge)).to eq(
      api_key: {
        key: :api_key,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ],
            alias: [
              'api-key'
            ]
          }
        ]
      },
      app_file: {
        key: :app_file,
        types: [
          {
            type: :scalar,
            alias: [
              "app-file"
            ]
          }
        ]
      },
      symbols_file: {
        key: :symbols_file,
        types: [
          {
            type: :scalar,
            alias: [
              "symbols-file"
            ]
          }
        ]
      },
      keystore_file: {
        key: :keystore_file,
        types: [
          {
            type: :scalar,
            alias: [
              "keystore-file"
            ]
          }
        ]
      },
      storepass: {
        key: :storepass,
        types: [
          {
            type: :scalar
          }
        ]
      },
      alias: {
        key: :alias,
        types: [
          {
            type: :scalar
          }
        ]
      },
      testers_groups: {
        key: :testers_groups,
        types: [
          {
            type: :scalar,
            alias: [
              "testers-groups"
            ]
          }
        ]
      },
      notify: {
        key: :notify,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ]
          }
        ]
      },
      auto_update: {
        key: :auto_update,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ],
            alias: [
              "auto-update"
            ]
          }
        ]
      },
      video_quality: {
        key: :video_quality,
        types: [
          {
            type: :scalar,
            alias: [
              "video-quality"
            ]
          }
        ]
      },
      screenshot_quality: {
        key: :screenshot_quality,
        types: [
          {
            type: :scalar,
            alias: [
              "screenshot-quality"
            ]
          }
        ]
      },
      screenshot_interval: {
        key: :screenshot_interval,
        types: [
          {
            type: :scalar,
            alias: [
              "screenshot-interval"
            ]
          }
        ]
      },
      max_duration: {
        key: :max_duration,
        types: [
          {
            type: :scalar,
            alias: [
              "max-duration"
            ]
          }
        ]
      },
      advanced_options: {
        key: :advanced_options,
        types: [
          {
            type: :scalar,
            alias: [
              "advanced-options"
            ]
          }
        ]
      },
      data_only_wifi: {
        key: :data_only_wifi,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ],
            alias: [
              "data-only-wifi"
            ]
          }
        ]
      },
      record_on_backgroup: {
        key: :record_on_backgroup,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ],
            alias: [
              "record-on-backgroup"
            ]
          }
        ]
      },
      video: {
        key: :video,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ]
          }
        ]
      },
      icon_watermark: {
        key: :icon_watermark,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ],
            alias: [
              "icon-watermark"
            ]
          }
        ]
      },
      metrics: {
        key: :metrics,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
