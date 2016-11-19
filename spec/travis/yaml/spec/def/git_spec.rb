describe Travis::Yaml::Spec::Def::Git do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :git,
      type: :map,
      map: {
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
        },
        quiet: {
          key: :quiet,
          types: [
            {
              type: :scalar,
              cast: :bool
            }
          ]
        },
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
              cast: :bool
            }
          ]
        },
        submodules_depth: {
          key: :submodules_depth,
          types: [
            {
              type: :scalar
            }
          ]
        }
      }
    )
  end
end
