describe Travis::Yaml::Spec::Def::Deploy::Bitballoon do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :bitballoon,
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
      access_token: {
        key: :access_token,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      site_id: {
        key: :site_id,
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
            type: :scalar
          }
        ]
      }
    )
  end
end