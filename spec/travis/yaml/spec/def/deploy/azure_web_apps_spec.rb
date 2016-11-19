describe Travis::Yaml::Spec::Def::Deploy::AzureWebApps do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :azure_web_apps,
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
      site: {
        key: :site,
        types: [
          {
            type: :scalar
          }
        ]
      },
      slot: {
        key: :slot,
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
      verbose: {
        key: :verbose,
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
