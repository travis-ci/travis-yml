describe Travis::Yaml::Spec::Def::Language do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :language,
      type: :fixed,
      alias: ['lang'],
      defaults: [
        { value: 'ruby' }
      ],
      downcase: true
    )
  end
end
