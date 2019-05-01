describe Travis::Yml::Schema::Def::Deploy::Scalingo, 'schema' do
  subject { Travis::Yml.schema[:definitions][:deploy][:scalingo] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_scalingo,
        title: 'Deploy Scalingo',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'scalingo'
                ],
                strict: true
              },
              on: {
                '$ref': '#/definitions/deploy/conditions'
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
                aliases: [
                  :user
                ]
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              api_key: {
                '$ref': '#/definitions/type/secure'
              },
              remote: {
                type: :string
              },
              branch: {
                type: :string
              },
              app: {
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
              'scalingo'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
