describe Travis::Yml::Schema::Def::Deploy::Gcs do
  subject { Travis::Yml.schema[:definitions][:deploy][:gcs] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :gcs,
        title: 'Gcs',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'gcs'
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
                type: :string
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
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              secret_access_key: {
                '$ref': '#/definitions/type/secure'
              },
              bucket: {
                type: :string
              },
              upload_dir: {
                type: :string
              },
              local_dir: {
                type: :string
              },
              dot_match: {
                type: :boolean
              },
              acl: {
                type: :string
              },
              cache_control: {
                type: :string
              },
              detect_encoding: {
                type: :boolean
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :provider
            },
            required: [
              :provider
            ]
          },
          {
            type: :string,
            enum: [
              'gcs'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
