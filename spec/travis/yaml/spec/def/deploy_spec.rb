describe Travis::Yaml::Spec::Def::Deploy::Deploy do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :deploy,
      type: :map,
      strict: false,
      prefix: {
        key: :provider,
        type: :scalar
      },
      map: {
        provider: {
          key: :provider,
          types: [{ type: :scalar, required: true }]
        },
        on: {
          key: :on,
          types: [
            {
              name: :deploy_conditions,
              type: :map,
              strict: false,
              prefix: {
                key: :branch
              },
              map: {
                branch: {
                  key: :branch,
                  types: [{ type: :seq, types: [{ type: :scalar }] }]
                },
                repo: {
                  key: :repo,
                  types: [{ type: :scalar }]
                },
                condition: {
                  key: :condition,
                  types: [{ type: :scalar } ]
                },
                all_branches: {
                  key: :all_branches,
                  types: [{ type: :scalar, cast: [:bool] }]
                },
                tags: {
                  key: :tags,
                  types: [{ type: :scalar, cast: [:bool] }]
                }
              }
            }
          ]
        },
        skip_cleanup: {
          key: :skip_cleanup,
          types: [{ type: :scalar, cast: [:bool] } ]
        },
        edge: {
          key: :edge,
          types: [
            { type: :scalar, cast: [:bool], edge: true }
          ]
        }
      }
    )
  end
end

