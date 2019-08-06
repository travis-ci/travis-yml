describe Travis::Yml::Schema::Def::Deploy::Launchpad do
  subject { Travis::Yml.schema[:definitions][:deploy][:launchpad] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :launchpad,
        title: 'Launchpad',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'launchpad'
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
              slug: {
                type: :string
              },
              oauth_token: {
                '$ref': '#/definitions/type/secure'
              },
              oauth_token_secret: {
                '$ref': '#/definitions/type/secure'
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
              :slug,
              :oauth_token,
              :oauth_token_secret,
              :provider,
            ]
          },
          {
            type: :string,
            enum: [
              'launchpad'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
