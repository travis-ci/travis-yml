describe Travis::Yaml::Spec::Def::Jdks do
  let(:spec) { Travis::Yaml.support[:map][:jdk][:types][0] }

  it do
    expect(spec).to eq(
      name: :jdks,
      type: :seq,
      types: [
        name: :jdk,
        type: :scalar
      ],
      expand: true,
      only: {
        language: ['android', 'clojure', 'groovy', 'java', 'ruby', 'scala']
      },
      except: {
        os: ['osx']
      },
    )
  end
end
