describe Travis::Yaml::Spec::Def::Deploy::Pypi do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :pypi,
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
      server: {
        key: :server,
        types: [
          {
            type: :scalar
          }
        ]
      },
      distributions: {
        key: :distributions,
        types: [
          {
            type: :scalar
          }
        ]
      },
      docs_dir: {
        key: :docs_dir,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
