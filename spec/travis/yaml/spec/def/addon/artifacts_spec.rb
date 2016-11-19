describe Travis::Yaml::Spec::Def::Addons, 'artifacts' do
  let(:spec) { described_class.new.spec[:map][:artifacts] }

  it do
    expect(spec).to eq(
      key: :artifacts,
      types: [
        {
          name: :artifacts,
          type: :map,
          normalize: [
            {
              name: :enabled
            }
          ],
          map: {
            enabled: {
              key: :enabled,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :bool
                  ]
                }
              ]
            },
            bucket: {
              key: :bucket,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :secure
                  ]
                }
              ]
            },
            endpoint: {
              key: :endpoint,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :secure
                  ]
                }
              ]
            },
            key: {
              key: :key,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :secure
                  ]
                }
              ]
            },
            secret: {
              key: :secret,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :secure
                  ]
                }
              ]
            },
            paths: {
              key: :paths,
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
            },
            branch: {
              key: :branch,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            log_format: {
              key: :log_format,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            target_paths: {
              key: :target_paths,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            debug: {
              key: :debug,
              types: [
                {
                  type: :scalar,
                  cast: [
                    :bool
                  ]
                }
              ]
            },
            concurrency: {
              key: :concurrency,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            max_size: {
              key: :max_size,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            s3_region: {
              key: :s3_region,
              types: [
                {
                  type: :scalar
                }
              ]
            }
          }
        }
      ]
    )
  end
end
