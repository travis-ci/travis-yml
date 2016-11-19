describe Travis::Yaml::Spec::Def::Dist do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :dist,
      type: :fixed,
      defaults: [
        { value: 'precise' }
      ],
      downcase: true,
      values: [
        { value: 'precise' },
        { value: 'trusty' },
        { value: 'osx', alias: ['mac', 'macos', 'ios'] }
      ]
    )
  end
end
