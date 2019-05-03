describe Travis::Yml::Schema::Def::Deploy::Bitballoon do
  subject { Travis::Yml.schema[:definitions][:deploy][:bitballoon] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_bitballoon,
        title: 'Deploy Bitballoon',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'bitballoon'
                ],
                strict: true
              },
              on: {
                '$ref': '#/definitions/deploy/conditions',
                aliases: [
                  :true
                ]
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
              'access-token': {
                '$ref': '#/definitions/type/secure'
              },
              'site-id': {
                '$ref': '#/definitions/type/secure'
              },
              'local-dir': {
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
              'bitballoon'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
