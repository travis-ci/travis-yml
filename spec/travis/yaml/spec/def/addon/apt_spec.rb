describe Travis::Yaml::Spec::Def::Addons, 'apt' do
  let(:spec) { described_class.new.spec[:map][:apt] }

  it do
    expect(spec).to eq(
      key: :apt,
      types: [
        name: :apt,
        type: :map,
        prefix: {
          key: :packages
        },
        map: {
          packages: {
            key: :packages,
            types: [
              {
                type: :seq,
                types: [
                  type: :scalar
                ]
              }
            ]
          },
          sources: {
            key: :sources,
            types: [
              {
                name: :apt_sources,
                type: :seq,
                types: [
                  {
                    type: :scalar,
                    strict: false
                  },
                  {
                    type: :map,
                    strict: false,
                  }
                ]
              }
            ]
          },
          dist: {
            key: :dist,
            types: [
              {
                type: :scalar
              }
            ]
          }
        }
      ]
    )
  end
end
