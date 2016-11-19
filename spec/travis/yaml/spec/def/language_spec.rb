describe Travis::Yaml::Spec::Def::Language do
  let(:root) { Travis::Yaml::Spec::Def::Root.new }
  let(:spec) { described_class.new(root).spec }

  it do
    expect(except(spec, :values)).to eq(
      name: :language,
      type: :fixed,
      defaults: [
        { value: 'ruby' }
      ],
      downcase: true,
    )
  end
end
