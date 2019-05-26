describe Travis::Yml::Schema::Def::Deploy::Hackage do
  subject { Travis::Yml.schema[:definitions][:deploy][:hackage] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :hackage,
        title: 'Hackage',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'hackage'
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
              username: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              password: {
                '$ref': '#/definitions/type/secure'
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
              'hackage'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
