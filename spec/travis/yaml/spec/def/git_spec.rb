describe Travis::Yaml::Spec::Def::Git do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :git,
      type: :map,
      map: {
        depth: {
          key: :depth,
          types: [
            {
              type: :scalar,
              defaults: [
                { value: 50 }
              ]
            }
          ]
        },
        submodules: {
          key: :submodules,
          types: [
            {
              type: :scalar,
              cast: [:bool]
            }
          ]
        },
        strategy: {
          key: :strategy,
          types: [
            {
              type: :fixed,
              values: [
                { value: 'clone' },
                { value: 'tarball' }
              ]
            }
          ]
        }
      }
    )
  end
end
