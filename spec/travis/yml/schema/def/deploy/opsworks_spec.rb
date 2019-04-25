describe Travis::Yml::Schema::Def::Deploy::Opsworks, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:opsworks] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_opsworks,
        title: 'Deploy Opsworks',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'opsworks'
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
                '$ref': '#/definitions/type/secure'
              },
              secret_access_key: {
                '$ref': '#/definitions/type/secure'
              },
              app_id: {
                type: :string
              },
              instance_ids: {
                type: :string
              },
              layer_ids: {
                type: :string
              },
              migrate: {
                type: :boolean
              },
              wait_until_deployed: {
                type: :string
              },
              custom_json: {
                type: :string
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
              'opsworks'
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
        '$ref': '#/definitions/deploy/opsworks'
      )
    end
  end
end
