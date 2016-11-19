describe Travis::Yaml::Spec::Def::Addons, 'apt_packages' do
  let(:spec) { described_class.new.spec[:map][:apt_packages] }

  it do
    expect(spec).to eq(
      key: :apt_packages,
      types: [
        type: :seq,
        types: [
          type: :scalar
        ]
      ]
    )
  end
end
