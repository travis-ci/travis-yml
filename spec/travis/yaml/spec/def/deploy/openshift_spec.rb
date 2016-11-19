describe Travis::Yaml::Spec::Def::Deploy::Openshift do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :openshift,
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
      domain: {
        key: :domain,
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
      deployment_branch: {
        key: :deployment_branch,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
