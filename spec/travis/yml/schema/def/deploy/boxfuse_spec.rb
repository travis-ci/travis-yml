describe Travis::Yml::Schema::Def::Deploy::Boxfuse, 'schema' do
  subject { Travis::Yml.schema[:definitions][:deploy][:boxfuse] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_boxfuse,
        title: 'Deploy Boxfuse',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'boxfuse'
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
              user: {
                '$ref': '#/definitions/type/secure'
              },
              secret: {
                '$ref': '#/definitions/type/secure'
              },
              configfile: {
                type: :string
              },
              payload: {
                type: :string
              },
              app: {
                type: :string
              },
              version: {
                type: :string
              },
              env: {
                type: :string
              },
              image: {
                type: :string
              },
              extra_args: {
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
              'boxfuse'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
