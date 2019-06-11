describe Travis::Yml::Schema::Def::Deploy::Npm do
  subject { Travis::Yml.schema[:definitions][:deploy][:npm] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :npm,
        title: 'Npm',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'npm'
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
              email: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              api_key: {
                '$ref': '#/definitions/type/secure'
              },
              tag: {
                type: :string
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
              'npm'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
