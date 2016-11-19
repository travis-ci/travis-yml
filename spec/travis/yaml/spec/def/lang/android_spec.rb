describe Travis::Yaml::Spec::Def::Android do
  let(:lang)    { Travis::Yaml.spec[:map][:language][:types][0][:values] }
  let(:android) { Travis::Yaml.support[:map][:android] }

  it { expect(lang).to include(value: 'android') }

  it do
    expect(android).to eq(
      key: :android,
      types: [
        name: :android_config,
        type: :map,
        only: {
          language: [
            "android"
          ]
        },
        map: {
          components: {
            key: :components,
            types: [
              {
                type: :seq,
                types: [
                  {
                    type: :scalar
                  }
                ]
              }
            ]
          },
          licenses: {
            key: :licenses,
            types: [
              {
                type: :seq,
                types: [
                  {
                    type: :scalar
                  }
                ]
              }
            ]
          }
        }
      ]
    )
  end
end
