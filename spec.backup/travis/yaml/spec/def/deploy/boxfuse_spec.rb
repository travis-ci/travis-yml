describe Travis::Yaml::Spec::Def::Deploy::Boxfuse do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :boxfuse,
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
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      secret: {
        key: :secret,
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
      configfile: {
        key: :configfile,
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
      payload: {
        key: :payload,
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
      app: {
        key: :app,
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
      version: {
        key: :version,
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
      env: {
        key: :env,
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
      image: {
        key: :image,
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
      extra_args: {
        key: :extra_args,
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
