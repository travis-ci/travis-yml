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
              registry: {
                type: :string
              },
              email: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              api_token: {
                '$ref': '#/definitions/type/secure',
                aliases: [
                  :api_key
                ]
              },
              access: {
                type: :string
              },
              tag: {
                type: :string
              },
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
              'npm'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
