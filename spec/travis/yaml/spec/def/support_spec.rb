describe Travis::Yaml::Spec::Def::Support do
  let(:spec) { Travis::Yaml.spec[:includes][:support][:map] }

  it do
    expect(spec[:jdk]).to eq(
      key: :jdk,
      types: [
        name: :jdks,
        type: :seq,
        only: {
          language: ['android', 'clojure', 'groovy', 'java', 'ruby', 'scala']
        },
        expand: true,
        except: {
          os: ['osx']
        },
        types: [
          name: :jdk,
          type: :scalar
        ]
      ]
    )
  end

  it do
    expect(spec[:android]).to eq(
      key: :android,
      types: [
        name: :android_config,
        type: :map,
        only: {
          language: ['android']
        },
        map: {
          components: {
            key: :components,
            types: [
              type: :seq,
              types: [
                type: :scalar
              ]
            ]
          },
          licenses: {
            key: :licenses,
            types: [
              type: :seq,
              types: [
                type: :scalar
              ]
            ]
          }
        }
      ]
    )
  end
end
