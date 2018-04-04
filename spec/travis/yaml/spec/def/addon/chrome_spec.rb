describe Travis::Yaml::Spec::Def::Addon::Chrome do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :chrome,
      type: :fixed,
      downcase: true,
      values: [
        { value: 'stable' },
        { value: 'beta' }
      ]
    )
  end
end
