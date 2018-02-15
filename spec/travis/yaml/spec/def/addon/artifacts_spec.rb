describe Travis::Yaml::Spec::Def::Addons, 'artifacts' do
  let(:spec) { described_class.new.spec[:map][:artifacts] }

  it do
    expect(spec).to eq(
      key: :artifacts,
      types: [
        {
          name: :artifacts,
          type: :map,
          change: [
            {
              name: :enable
            }
          ],
          map: {
            enabled: {
              key: :enabled,
              types: [
                {
                  type: :scalar,
                  cast: :bool
                }
              ]
            },
            bucket: {
              key: :bucket,
              types: [
                {
                  type: :scalar,
                }
              ]
            },
            endpoint: {
              key: :endpoint,
              types: [
                {
                  type: :scalar,
                }
              ]
            },
            key: {
              key: :key,
              types: [
                {
                  type: :scalar,
                  secure: true,
                  alias: [
                    'aws_access_key',
                    'access_key'
                  ],
                }
              ],
            },
            secret: {
              key: :secret,
              types: [
                {
                  type: :scalar,
                  secure: true,
                  alias: [
                    'secret_key',
                    'secret_access_key',
                    'aws_secret',
                    'aws_secret_key',
                    'aws_secret_access_key'
                  ],
                }
              ],
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
                  type: :seq,
                  types: [
                    { type: :scalar }
                  ]
                }
              ]
            },
            debug: {
              key: :debug,
              types: [
                {
                  type: :scalar,
                  cast: :bool
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
            region: {
              key: :region,
              types: [
                {
                  type: :scalar,
                  alias: ['s3_region'],
                }
              ]
            },
            permissions: {
              key: :permissions,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            working_dir: {
              key: :working_dir,
              types: [
                {
                  type: :scalar
                }
              ]
            },
            cache_control: {
              key: :cache_control,
              types: [
                {
                  type: :scalar
                }
              ]
            },
          }
        }
      ]
    )
  end
end
