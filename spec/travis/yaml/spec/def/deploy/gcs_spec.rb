describe Travis::Yaml::Spec::Def::Deploy::Gcs do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :gcs,
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
      bucket: {
        key: :bucket,
        types: [
          {
            type: :scalar
          }
        ]
      },
      upload_dir: {
        key: :upload_dir,
        types: [
          {
            type: :scalar,
            alias: [
              "upload-dir"
            ]
          }
        ]
      },
      local_dir: {
        key: :local_dir,
        types: [
          {
            type: :scalar,
            alias: [
              "local-dir"
            ]
          }
        ]
      },
      dot_match: {
        key: :dot_match,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ]
          }
        ]
      },
      acl: {
        key: :acl,
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
      detect_encoding: {
        key: :detect_encoding,
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
