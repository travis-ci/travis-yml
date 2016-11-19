describe Travis::Yaml::Spec::Def::Deploy::S3 do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :s3,
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
      region: {
        key: :region,
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
      storage_class: {
        key: :storage_class,
        types: [
          {
            type: :scalar,
            alias: [
              "storage-class"
            ]
          }
        ]
      },
      local_dir: {
        key: :local_dir,
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
      },
      cache_control: {
        key: :cache_control,
        types: [
          {
            type: :scalar
          }
        ]
      },
      expires: {
        key: :expires,
        types: [
          {
            type: :scalar
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
      index_document_suffix: {
        key: :index_document_suffix,
        types: [
          {
            type: :scalar
          }
        ]
      },
      default_text_charset: {
        key: :default_text_charset,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
