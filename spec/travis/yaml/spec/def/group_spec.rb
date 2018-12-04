describe Travis::Yaml::Spec::Def::Group do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :group,
      type: :scalar,
      defaults: [
        { value: 'stable' }
      ],
      downcase: true
    )
  end
end
