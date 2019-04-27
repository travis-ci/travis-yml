describe Travis::Yml::Schema::Def::Deploy::Codedeploy, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:codedeploy] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_codedeploy,
        title: 'Deploy Codedeploy',
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
              },
              bundle_type: {
                type: :string
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
              'codedeploy'
            ],
            strict: true
          }
        ],
        normal: true
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
