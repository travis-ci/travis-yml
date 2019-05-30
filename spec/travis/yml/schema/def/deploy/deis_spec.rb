describe Travis::Yml::Schema::Def::Deploy::Deis do
  subject { Travis::Yml.schema[:definitions][:deploy][:deis] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deis,
        title: 'Deis',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'deis'
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
              'deis'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
