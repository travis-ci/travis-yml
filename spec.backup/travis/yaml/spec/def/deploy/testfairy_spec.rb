describe Travis::Yaml::Spec::Def::Deploy::Testfairy do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :testfairy,
      type: :map,
      strict: false,
      prefix: {
        key: :provider,
        type: [:str]
      },
      types: [
        {
          name: :deploy_branches,
          type: :map,
          strict: false,
          deprecated: :branch_specific_option_hash
        }
      ]
    )
  end

  it do
    expect(except(spec[:map], :provider, :on, :skip_cleanup, :allow_failure, :edge)).to eq(
      api_key: {
        key: :api_key,
        types: [
          {
            type: :scalar,
            secure: true,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      app_file: {
        key: :app_file,
        types: [
          {
            type: :scalar,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      symbols_file: {
        key: :symbols_file,
        types: [
          {
            type: :scalar,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      testers_groups: {
        key: :testers_groups,
        types: [
          {
            type: :scalar,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      notify: {
        key: :notify,
        types: [
          {
            type: :scalar,
            cast: :bool
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      auto_update: {
        key: :auto_update,
        types: [
          {
            type: :scalar,
            cast: :bool,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      video_quality: {
        key: :video_quality,
        types: [
          {
            type: :scalar,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      screenshot_quality: {
        key: :screenshot_quality,
        types: [
          {
            type: :scalar,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      screenshot_interval: {
        key: :screenshot_interval,
        types: [
          {
            type: :scalar,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      max_duration: {
        key: :max_duration,
        types: [
          {
            type: :scalar,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      advanced_options: {
        key: :advanced_options,
        types: [
          {
            type: :scalar,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      data_only_wifi: {
        key: :data_only_wifi,
        types: [
          {
            type: :scalar,
            cast: :bool,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      record_on_backgroup: {
        key: :record_on_backgroup,
        types: [
          {
            type: :scalar,
            cast: :bool,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      video: {
        key: :video,
        types: [
          {
            type: :scalar,
            cast: :bool,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      icon_watermark: {
        key: :icon_watermark,
        types: [
          {
            type: :scalar,
            cast: :bool,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      metrics: {
        key: :metrics,
        types: [
          {
            type: :scalar
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      }
    )
  end
end
