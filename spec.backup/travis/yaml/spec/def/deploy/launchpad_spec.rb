describe Travis::Yaml::Spec::Def::Deploy::Launchpad do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :launchpad,
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
      slug: {
        key: :slug,
        types: [
          {
            type: :scalar,
            required: true
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            deprecated: :branch_specific_option_hash
          }
        ]
      },
      oauth_token: {
        key: :oauth_token,
        types: [
          {
            type: :scalar,
            required: true,
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
      oauth_token_secret: {
        key: :oauth_token_secret,
        types: [
          {
            type: :scalar,
            required: true,
            secure: true,
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
