describe Travis::Yaml::Spec::Def::BranchConditions do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :branch_conditions,
      type: :map,
      prefix: {
        key: :only
      },
      map: {
        only: {
          key: :only,
          types: [
            {
              name: :branches,
              type: :seq,
              types: [
                {
                  name: :branch,
                  type: :scalar,
                  cast: [:str, :regex]
                }
              ]
            }
          ]
        },
        except: {
          key: :except,
          types: [
            {
              name: :branches,
              type: :seq,
              types: [
                {
                  name: :branch,
                  type: :scalar,
                  cast: [:str, :regex]
                }
              ]
            }
          ]
        }
      }
    )
  end
end

