describe Travis::Yaml::Spec::Def::Env do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :env,
      type: :map,
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
              normalize: [name: :vars],
              types: [
                {
                  name: :env_var,
                  type: :scalar,
                  cast: [
                    :str,
                    :secure
                  ]
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
              normalize: [name: :vars],
              types: [
                {
                  name: :env_var,
                  type: :scalar,
                  cast: [
                    :str,
                    :secure
                  ]
                }
              ]
            }
          ]
        }
      }
    )
  end
end

