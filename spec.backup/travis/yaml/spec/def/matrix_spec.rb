describe Travis::Yaml::Spec::Def::Matrix do
  let(:root) { Travis::Yaml::Spec::Def::Root.new }
  let(:spec) { described_class.new(root).spec }

  it do
    expect(except(spec, :map, :expand, :prefix)).to eq(
      name: :matrix,
      type: :map,
    )
  end

  it do
    expect(spec[:map][:include][:types][0][:types][0][:map][:name]).to eq(
      key: :name,
      types: [
        type: :scalar
      ]
    )
  end

  it { expect(spec[:prefix][:key]).to eq :include }
  it { expect(spec[:prefix][:only]).to include :language }
end
