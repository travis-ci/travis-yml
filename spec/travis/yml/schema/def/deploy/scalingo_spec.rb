describe Travis::Yml::Schema::Def::Deploy::Scalingo do
  subject { Travis::Yml.schema[:definitions][:deploy][:scalingo] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :scalingo,
        title: 'Scalingo',
        anyOf: [
          {
            type: :object,
            properties: {
              api_token: {
                '$ref': '#/definitions/type/secure',
                aliases: [
                  :api_key
                ]
              },
              username: {
                '$ref': '#/definitions/type/secure',
                strict: false,
                aliases: [
                  :user
                ]
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              remote: {
                type: :string
              },
              branch: {
                type: :string
              },
              region: {
                type: :string
              },
              app: {
                type: :string
              },
              timeout: {
                type: :number
              },
              provider: {
                type: :string,
                enum: [
                  'scalingo'
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
              'scalingo'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
