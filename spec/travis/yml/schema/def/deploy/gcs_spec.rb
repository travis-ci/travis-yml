describe Travis::Yml::Schema::Def::Deploy::Gcs, 'structure' do
  describe 'definitions' do
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
                '$ref': '#/definitions/type/deploy_conditions'
              },
              allow_failure: {
                type: :boolean
              },
              skip_cleanup: {
                type: :boolean
              },
              edge: {
                '$ref': '#/definitions/type/deploy_edge'
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
            normal: true,
            prefix: :provider,
            required: [
              :provider
            ],
            changes: [
              {
                change: :enable
              }
            ]
          },
          {
            type: :string,
            enum: [
              'gcs'
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
        '$ref': '#/definitions/deploy/gcs'
      )
    end
  end
end
