describe Travis::Yml::Schema::Def::Deploy::Boxfuse do
  subject { Travis::Yml.schema[:definitions][:deploy][:boxfuse] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :boxfuse,
        title: 'Boxfuse',
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
              user: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              secret: {
                '$ref': '#/definitions/type/secure'
              },
              config_file: {
                type: :string,
                aliases: [
                  :configfile
                ]
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
              args: {
                type: :string,
                aliases: [
                  :extra_args
                ]
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
              'boxfuse'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
