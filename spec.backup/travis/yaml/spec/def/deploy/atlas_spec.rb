describe Travis::Yaml::Spec::Def::Deploy::Atlas do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :atlas,
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
      token: {
        key: :token,
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
      exclude: {
        key: :exclude,
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
      include: {
        key: :include,
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
      address: {
        key: :address,
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
      vcs: {
        key: :vcs,
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
      metadata: {
        key: :metadata,
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
      debug: {
        key: :debug,
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
      }
    )
  end
end
