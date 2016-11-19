describe Travis::Yaml::Spec::Def::Deploy::Heroku do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :heroku,
      type: :map,
      strict: false,
      prefix: {
        key: :provider,
        type: :scalar
      }
    )
  end

  it do
    expect(except(spec[:map], :provider, :on, :skip_cleanup, :edge)).to eq(
      strategy: {
        key: :strategy,
        types: [
          {
            type: :scalar
          }
        ]
      },
      buildpack: {
        key: :buildpack,
        types: [
          {
            type: :scalar
          }
        ]
      },
      app: {
        key: :app,
        types: [
          {
            type: :scalar,
            strict: false
          },
          {
            name: :deploy_branches,
            type: :map,
            strict: false,
            map: {},
            types: [
              {
                name: :branch,
                type: :scalar,
                cast: [
                  :str,
                  :regex
                ]
              }
            ]
          }
        ]
      },
      api_key: {
        key: :api_key,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ],
            alias: [
              "api-key"
            ]
          },
          {
            type: :map,
            cast: [
              :secure
            ],
            alias: [
              "api-key"
            ],
            strict: false,
            map: {}
          }
        ]
      },
      run: {
        key: :run,
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
    )
  end
end
