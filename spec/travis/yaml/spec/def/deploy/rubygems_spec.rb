describe Travis::Yaml::Spec::Def::Deploy::Rubygems do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :rubygems,
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
      gem: {
        key: :gem,
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
      file: {
        key: :file,
        types: [
          {
            type: :scalar
          }
        ]
      },
      gemspec: {
        key: :gemspec,
        types: [
          {
            type: :scalar
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
          },
          {
            type: :map,
            cast: [
              :secure
            ],
            strict: false,
            map: {}
          }
        ]
      }
    )
  end
end