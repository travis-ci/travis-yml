describe Travis::Yml::Schema::Def::Deploy::Cloudfiles do
  subject { Travis::Yml.schema[:definitions][:deploy][:cloudfiles] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_cloudfiles,
        title: 'Deploy Cloudfiles',
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
              key: :provider
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
