describe Travis::Yml::Schema::Def::Deploy::Transifex do
  subject { Travis::Yml.schema[:definitions][:deploy][:transifex] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :transifex,
        title: 'Transifex',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'transifex'
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
              username: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              hostname: {
                type: :string
              },
              cli_version: {
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
              'transifex'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
