describe Travis::Yml::Schema::Def::Deploy::Puppetforge do
  subject { Travis::Yml.schema[:definitions][:deploy][:puppetforge] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :puppetforge,
        title: 'Puppetforge',
        anyOf: [
          {
            type: :object,
            properties: {
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
              url: {
                type: :string
              },
              provider: {
                type: :string,
                enum: [
                  'puppetforge'
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
              :username,
              :password,
              :provider,
            ]
          },
          {
            type: :string,
            enum: [
              'puppetforge'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
