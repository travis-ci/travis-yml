describe Travis::Yaml::Spec::Def::Deploy::Scalingo do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :scalingo,
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
      username: {
        key: :username,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      password: {
        key: :password,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      api_key: {
        key: :api_key,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      remote: {
        key: :remote,
        types: [
          {
            type: :scalar
          }
        ]
      },
      branch: {
        key: :branch,
        types: [
          {
            type: :scalar
          }
        ]
      },
      app: {
        key: :app,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
