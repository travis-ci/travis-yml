describe Travis::Yaml::Spec::Def::Addons, 'apt' do
  let(:spec) { described_class.new.spec[:map][:apt] }

  it do
    expect(spec).to eq(
      key: :apt,
      types: [
        name: :apt,
        type: :map,
        map: {
          sources: {
            key: :sources,
            types: [
              {
                type: :seq,
                types: [type: :scalar]
              }
            ]
          },
          packages: {
            key: :packages,
            types: [
              {
                type: :seq,
                types: [type: :scalar]
              }
            ]
          }
        }
      ]
    )
  end
end
