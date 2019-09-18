describe Travis::Yml::Schema::Def::Deploy::Cloud66 do
  subject { Travis::Yml.schema[:definitions][:deploy][:cloud66] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :cloud66,
        title: 'Cloud66',
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
              redeployment_hook: {
                '$ref': '#/definitions/type/secure',
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
              'cloud66'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
