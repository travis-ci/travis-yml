describe Travis::Yaml::Spec::Def::Deploy::Bintray do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :bintray,
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
      file: {
        key: :file,
        types: [
          {
            type: :scalar
          }
        ]
      },
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
      key: {
        key: :key,
        types: [
          {
            type: :scalar
          }
        ]
      },
      passphrase: {
        key: :passphrase,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      dry_run: {
        key: :dry_run,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ],
            alias: [
              "dry-run"
            ]
          }
        ]
      }
    )
  end
end
