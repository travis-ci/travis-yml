describe Travis::Yaml::Spec::Def::Deploy::Packagecloud do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :packagecloud,
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
      token: {
        key: :token,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      repository: {
        key: :repository,
        types: [
          {
            type: :scalar
          }
        ]
      },
      local_dir: {
        key: :local_dir,
        types: [
          {
            type: :scalar,
            alias: [
              "local-dir"
            ]
          }
        ]
      },
      dist: {
        key: :dist,
        types: [
          {
            type: :scalar
          }
        ]
      },
      package_glob: {
        key: :package_glob,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
