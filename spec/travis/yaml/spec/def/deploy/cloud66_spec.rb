describe Travis::Yaml::Spec::Def::Deploy::Cloud66 do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :cloud66,
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
      redeployment_hook: {
        key: :redeployment_hook,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end