describe Travis::Yaml::Spec::Def::Group do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :group,
      type: :fixed,
      defaults: [
        { value: 'stable' }
      ],
      downcase: true,
      flagged: true,
      values: [
        { value: 'stable' },
        { value: 'edge' },
        { value: 'dev' },
      ]
    )
  end
end
