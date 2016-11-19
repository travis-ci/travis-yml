describe Travis::Yaml::Spec::Def::Deploy::Elasticbeanstalk do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :elasticbeanstalk,
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
      securet_access_key: {
        key: :securet_access_key,
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
      region: {
        key: :region,
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
            type: :scalar
          }
        ]
      },
      env: {
        key: :env,
        types: [
          {
            type: :scalar
          }
        ]
      },
      zip_file: {
        key: :zip_file,
        types: [
          {
            type: :scalar
          }
        ]
      },
      bucket_name: {
        key: :bucket_name,
        types: [
          {
            type: :scalar
          }
        ]
      },
      bucket_path: {
        key: :bucket_path,
        types: [
          {
            type: :scalar
          }
        ]
      },
      only_create_app_version: {
        key: :only_create_app_version,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ]
          }
        ]
      }
    )
  end
end
