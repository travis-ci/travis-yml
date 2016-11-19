describe Travis::Yaml::Spec::Def::Deploy::Modulus do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :modulus,
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
      project_name: {
        key: :project_name,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end