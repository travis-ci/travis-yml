describe Travis::Yaml::Spec::Def::Branches do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :branches,
      type: :map,
      prefix: {
        key: :only,
        type: [:str, :seq]
      },
      map: {
        only: {
          key: :only,
          types: [
            {
              type: :seq,
              types: [
                {
                  type: :scalar,
                }
              ]
            }
          ]
        },
        except: {
          key: :except,
          types: [
            {
              type: :seq,
              alias: ['exclude'],
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

