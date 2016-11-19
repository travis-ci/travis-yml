describe Travis::Yaml::Spec::Def::Deploy::Script do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :script,
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
      script: {
        key: :script,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end