describe Travis::Yaml::Spec::Def::Deploy::Launchpad do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :launchpad,
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
      slug: {
        key: :slug,
        types: [
          {
            type: :scalar,
            required: true
          }
        ]
      },
      oauth_token: {
        key: :oauth_token,
        types: [
          {
            type: :scalar,
            required: true,
            cast: [
              :secure
            ]
          }
        ]
      },
      oauth_token_secret: {
        key: :oauth_token_secret,
        types: [
          {
            type: :scalar,
            required: true,
            cast: [
              :secure
            ]
          }
        ]
      }
    )
  end
end
