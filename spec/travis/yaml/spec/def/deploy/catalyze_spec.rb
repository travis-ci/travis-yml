describe Travis::Yaml::Spec::Def::Deploy::Catalyze do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :catalyze,
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
      target: {
        key: :target,
        types: [
          {
            type: :scalar
          }
        ]
      },
      path: {
        key: :path,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end