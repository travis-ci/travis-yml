describe Travis::Yml::Schema::Def::Deploy::Codedeploy do
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
              description: {
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
              },
              endpoint: {
                type: :string
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
              'codedeploy'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
