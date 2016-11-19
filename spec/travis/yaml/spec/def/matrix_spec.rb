describe Travis::Yaml::Spec::Def::Matrix do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :matrix,
      type: :map,
    )
  end
end
