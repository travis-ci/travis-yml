describe Travis::Yml::Schema::Def::Deploy::Hephy do
  subject { Travis::Yml.schema[:definitions][:deploy][:hephy] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :hephy,
        title: 'Hephy',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'hephy'
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
                type: :string
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
              controller: {
                type: :string
              },
              username: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              app: {
                type: :string
              },
              cli_version: {
                type: :string
              },
              verbose: {
                type: :boolean
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
              'hephy'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
