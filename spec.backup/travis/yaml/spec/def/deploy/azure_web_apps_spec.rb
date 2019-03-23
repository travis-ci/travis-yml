describe Travis::Yaml::Spec::Def::Deploy::AzureWebApps do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :azure_web_apps,
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
      site: {
        key: :site,
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
      },
      slot: {
        key: :slot,
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
      },
      username: {
        key: :username,
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
      password: {
        key: :password,
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
      verbose: {
        key: :verbose,
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
      }
    )
  end
end
