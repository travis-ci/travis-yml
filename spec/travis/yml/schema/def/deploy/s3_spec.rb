describe Travis::Yml::Schema::Def::Deploy::S3, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:s3] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_s3,
        title: 'Deploy S3',
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
                '$ref': '#/definitions/deploy/conditions'
              },
              allow_failure: {
                type: :boolean
              },
              skip_cleanup: {
                type: :boolean
              },
              edge: {
                '$ref': '#/definitions/deploy/edge'
              },
              access_key_id: {
                '$ref': '#/definitions/secure'
              },
              secret_access_key: {
                '$ref': '#/definitions/secure'
              },
              bucket: {
                type: :string
              },
              region: {
                type: :string
              },
              upload_dir: {
                type: :string
              },
              storage_class: {
                type: :string
              },
              local_dir: {
                type: :string
              },
              detect_encoding: {
                type: :boolean
              },
              cache_control: {
                type: :string
              },
              expires: {
                type: :string
              },
              acl: {
                type: :string
              },
              dot_match: {
                type: :boolean
              },
              index_document_suffix: {
                type: :string
              },
              default_text_charset: {
                type: :string
              },
              server_side_encryption: {
                type: :boolean
              }
            },
            normal: true,
            prefix: :provider,
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
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/deploy/s3'
      )
    end
  end
end
