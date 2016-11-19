describe Travis::Yaml::Spec::Def::Deploy::Boxfuse do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :boxfuse,
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
      user: {
        key: :user,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      secret: {
        key: :secret,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      configfile: {
        key: :configfile,
        types: [
          {
            type: :scalar
          }
        ]
      },
      payload: {
        key: :payload,
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
      },
      version: {
        key: :version,
        types: [
          {
            type: :scalar
          }
        ]
      },
      env: {
        key: :env,
        types: [
          {
            type: :scalar
          }
        ]
      },
      image: {
        key: :image,
        types: [
          {
            type: :scalar
          }
        ]
      },
      extra_args: {
        key: :extra_args,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
