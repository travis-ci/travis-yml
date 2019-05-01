describe Travis::Yml::Schema::Def::Deploy::Cloud66, 'schema' do
  subject { Travis::Yml.schema[:definitions][:deploy][:cloud66] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_cloud66,
        title: 'Deploy Cloud66',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'cloud66'
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
              redeployment_hook: {
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
              'cloud66'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
