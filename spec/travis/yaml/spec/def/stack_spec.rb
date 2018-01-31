describe Travis::Yaml::Spec::Def::Stack do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :stack,
      downcase: true,
      type: :fixed,
      edge: true,
      values: [
        { value: 'connie' },
        { value: 'amethyst' },
        { value: 'garnet' },
        { value: 'stevonnie' },
        { value: 'opal' },
        { value: 'sardonyx' },
        { value: 'onion' },
        { value: 'cookiecat' }
      ]
    )
  end
end
