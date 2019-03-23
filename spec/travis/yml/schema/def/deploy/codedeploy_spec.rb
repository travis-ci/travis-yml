describe Travis::Yml::Schema::Def::Deploy::Codedeploy, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:codedeploy] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :codedeploy,
        title: 'Codedeploy',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'codedeploy'
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
              application: {
                type: :string
              },
              deployment_group: {
                type: :string
              },
              revision_type: {
                type: :string,
                enum: [
                  's3',
                  'github'
                ]
              },
              commit_id: {
                type: :string
              },
              repository: {
                type: :string
              },
              region: {
                type: :string
              },
              wait_until_deployed: {
                type: :boolean
              },
              bucket: {
                type: :string
              },
              key: {
                type: :string
              }
            },
            normal: true,
            prefix: :provider,
            changes: [
              {
                change: :enable
              }
            ],
            required: [
              :provider
            ]
          },
          {
            type: :string,
            enum: [
              'codedeploy'
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
        '$ref': '#/definitions/deploy/codedeploy'
      )
    end
  end
end
