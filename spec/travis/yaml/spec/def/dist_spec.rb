describe Travis::Yaml::Spec::Def::Dist do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :dist,
      type: :fixed,
      defaults: [
        { value: 'trusty' }
      ],
      downcase: true,
      values: [
        { value: 'trusty' },
        { value: 'precise' },
        { value: 'xenial', edge: true },
        { value: 'osx', alias: ['mac', 'macos', 'ios'] }
      ]
    )
  end
end
