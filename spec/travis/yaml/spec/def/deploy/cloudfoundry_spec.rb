describe Travis::Yaml::Spec::Def::Deploy::Cloudfoundry do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :cloudfoundry,
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
      organization: {
        key: :organization,
        types: [
          {
            type: :scalar
          }
        ]
      },
      api: {
        key: :api,
        types: [
          {
            type: :scalar
          }
        ]
      },
      space: {
        key: :space,
        types: [
          {
            type: :scalar
          }
        ]
      },
      key: {
        key: :key,
        types: [
          {
            type: :scalar
          }
        ]
      },
      manifest: {
        key: :manifest,
        types: [
          {
            type: :scalar
          }
        ]
      },
      skip_ssl_validation: {
        key: :skip_ssl_validation,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ]
          }
        ]
      }
    )
  end
end
