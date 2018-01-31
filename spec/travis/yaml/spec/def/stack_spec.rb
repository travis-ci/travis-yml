describe Travis::Yaml::Spec::Def::Stack do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :stack,
      downcase: true,
      type: :fixed,
      values: [
        { value: 'connie', edge: true },
        { value: 'amethyst', edge: true },
        { value: 'garnet', edge: true },
        { value: 'stevonnie', edge: true },
        { value: 'opal', edge: true },
        { value: 'sardonyx', edge: true },
        { value: 'onion', edge: true },
        { value: 'cookiecat', edge: true }
      ]
    )
  end
end
