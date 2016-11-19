describe Travis::Yaml::Spec::Def::Deploy::Appfog do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :appfog,
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
      user: {
        key: :user,
        types: [
          {
            type: :scalar,
            secure: true,
          },
          {
            type: :map,
            secure: true,
            strict: false,
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
            type: :map,
            secure: true,
            strict: false,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      email: {
        key: :email,
        types: [
          {
            type: :scalar,
          },
          {
            type: :map,
            strict: false,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      api_key: {
        key: :api_key,
        types: [
          {
            type: :scalar,
            secure: true,
          },
          {
            type: :map,
            secure: true,
            strict: false,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      app: {
        key: :app,
        types: [
          {
            type: :scalar
          },
          {
            type: :map,
            strict: false,
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      address: {
        key: :address,
        types: [
          {
            type: :seq,
            types: [
              {
                type: :scalar
              }
            ]
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      metadata: {
        key: :metadata,
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
      after_deploy: {
        key: :after_deploy,
        types: [
          {
            type: :seq,
            types: [
              {
                type: :scalar
              }
            ]
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
