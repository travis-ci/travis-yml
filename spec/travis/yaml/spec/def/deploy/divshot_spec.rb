describe Travis::Yaml::Spec::Def::Deploy::Divshot do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :divshot,
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
      environment: {
        key: :environment,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end