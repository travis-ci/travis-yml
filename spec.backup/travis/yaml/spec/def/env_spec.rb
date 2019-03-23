describe Travis::Yaml::Spec::Def::Env do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :env,
      type: :map,
      strict: false,
      prefix: {
        key: :matrix
      },
      map: {
        global: {
          key: :global,
          types: [
            {
              name: :env_vars,
              type: :seq,
              strict: false,
              change: [name: :env],
              types: [
                {
                  type: :scalar,

                }
              ]
            }
          ]
        },
        matrix: {
          key: :matrix,
          types: [
            {
              name: :env_vars,
              type: :seq,
              strict: false,
              change: [name: :env],
              types: [
                {
                  type: :scalar,
                }
              ]
            }
          ]
        }
      }
    )
  end
end

