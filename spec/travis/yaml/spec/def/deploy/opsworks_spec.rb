describe Travis::Yaml::Spec::Def::Deploy::Opsworks do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :opsworks,
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
      access_key_id: {
        key: :access_key_id,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ],
            alias: [
              "access-key-id"
            ]
          }
        ]
      },
      secret_access_key: {
        key: :secret_access_key,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ],
            alias: [
              "secret-access-key"
            ]
          }
        ]
      },
      app_id: {
        key: :app_id,
        types: [
          {
            type: :scalar,
            alias: [
              "app-id"
            ]
          }
        ]
      },
      instance_ids: {
        key: :instance_ids,
        types: [
          {
            type: :scalar,
            alias: [
              "instance-ids"
            ]
          }
        ]
      },
      layer_ids: {
        key: :layer_ids,
        types: [
          {
            type: :scalar,
            alias: [
              "layer-ids"
            ]
          }
        ]
      },
      migrate: {
        key: :migrate,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ]
          }
        ]
      },
      wait_until_deployed: {
        key: :wait_until_deployed,
        types: [
          {
            type: :scalar,
            alias: [
              "wait-until-deployed"
            ]
          }
        ]
      },
      custom_json: {
        key: :custom_json,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
