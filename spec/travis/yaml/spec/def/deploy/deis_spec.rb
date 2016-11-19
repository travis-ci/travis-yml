describe Travis::Yaml::Spec::Def::Deploy::Deis do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :deis,
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
      controller: {
        key: :controller,
        types: [
          {
            type: :scalar
          }
        ]
      },
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
      app: {
        key: :app,
        types: [
          {
            type: :scalar
          }
        ]
      },
      cli_version: {
        key: :cli_version,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
