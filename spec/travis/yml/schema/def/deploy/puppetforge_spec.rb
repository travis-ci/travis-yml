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
              user: {
                '$ref': '#/definitions/type/secure',
                strict: false
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
              skip_cleanup: {
                type: :boolean
              },
              edge: {
                '$ref': '#/definitions/deploy/edge'
              },
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :provider
            },
            required: [
              :user,
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
