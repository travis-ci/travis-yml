describe Travis::Yaml::Spec::Def::Deploy::Releases do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :releases,
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
      repo: {
        key: :repo,
        types: [
          {
            type: :scalar
          }
        ]
      },
      file: {
        key: :file,
        types: [
          {
            type: :seq,
            types: [
              {
                type: :scalar
              }
            ]
          },
          {
            type: :scalar
          }
        ]
      },
      file_glob: {
        key: :file_glob,
        types: [
          {
            type: :scalar
          }
        ]
      },
      overwrite: {
        key: :overwrite,
        types: [
          {
            type: :scalar
          }
        ]
      },
      release_number: {
        key: :release_number,
        types: [
          {
            type: :scalar,
            alias: [
              "release-number"
            ]
          }
        ]
      }
    )
  end
end
