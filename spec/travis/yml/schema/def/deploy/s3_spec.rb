describe Travis::Yml::Schema::Def::Deploy::S3 do
  subject { Travis::Yml.schema[:definitions][:deploy][:s3] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :s3,
        title: 'S3',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  's3'
                ],
                strict: true
              },
              on: {
                '$ref': '#/definitions/deploy/conditions',
                aliases: [
                  :true
                ]
              },
              run: {
                '$ref': '#/definitions/type/strs',
              },
              allow_failure: {
                type: :boolean
              },
              cleanup: {
                type: :boolean
              },
              skip_cleanup: {
                type: :boolean,
                deprecated: 'not supported in dpl v2, use cleanup'
              },
              edge: {
                '$ref': '#/definitions/deploy/edge'
              },
              access_key_id: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              secret_access_key: {
                '$ref': '#/definitions/type/secure'
              },
              bucket: {
                type: :string
              },
              region: {
                type: :string
              },
              endpoint: {
                type: :string
              },
              upload_dir: {
                type: :string
              },
              local_dir: {
                type: :string
              },
              glob: {
                type: :string
              },
              dot_match: {
                type: :boolean
              },
              acl: {
                type: :string
              },
              detect_encoding: {
                type: :boolean
              },
              cache_control: {
                '$ref': '#/definitions/type/strs',
              },
              expires: {
                '$ref': '#/definitions/type/strs',
              },
              default_text_charset: {
                type: :string
              },
              storage_class: {
                type: :string
              },
              server_side_encryption: {
                type: :boolean
              },
              index_document_suffix: {
                type: :string
              },
              overwrite: {
                type: :boolean
              },
              force_path_style: {
                type: :boolean
              },
              max_threads: {
                type: :number
              },
              verbose: {
                type: :boolean
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :provider,
              only: [
                :str
              ]
            },
            required: [
              :provider
            ]
          },
          {
            type: :string,
            enum: [
              's3'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
