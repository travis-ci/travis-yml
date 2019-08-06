describe Travis::Yml::Schema::Def::Deploy::Cloudfiles do
  subject { Travis::Yml.schema[:definitions][:deploy][:cloudfiles] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :cloudfiles,
        title: 'Cloudfiles',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'cloudfiles'
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
              username: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              api_key: {
                '$ref': '#/definitions/type/secure'
              },
              region: {
                type: :string
              },
              container: {
                type: :string
              },
              glob: {
                type: :string
              },
              dot_match: {
                type: :boolean
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
              'cloudfiles'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
