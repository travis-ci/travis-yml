describe Travis::Yaml::Spec::Def::Deploy::Engineyard do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :engineyard,
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
            ],
            alias: [
              "api-key"
            ]
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
            map: {}
          }
        ]
      },
      environment: {
        key: :environment,
        types: [
          {
            type: :map,
            strict: false,
            map: {}
          }
        ]
      },
      migrate: {
        key: :migrate,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
