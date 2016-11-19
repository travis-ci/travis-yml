describe Travis::Yaml::Spec::Def::Deploy::Surge do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :surge,
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
      project: {
        key: :project,
        types: [
          {
            type: :scalar
          }
        ]
      },
      domain: {
        key: :domain,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end