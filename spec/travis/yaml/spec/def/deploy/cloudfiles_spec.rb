describe Travis::Yaml::Spec::Def::Deploy::Cloudfiles do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :cloudfiles,
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
      region: {
        key: :region,
        types: [
          {
            type: :scalar
          }
        ]
      },
      container: {
        key: :container,
        types: [
          {
            type: :scalar
          }
        ]
      },
      dot_match: {
        key: :dot_match,
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
