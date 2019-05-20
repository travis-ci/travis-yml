describe Travis::Yml::Schema::Def::Deploy::Bintray do
  subject { Travis::Yml.schema[:definitions][:deploy][:bintray] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_bintray,
        title: 'Deploy Bintray',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'bintray'
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
              file: {
                type: :string
              },
              user: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              key: {
                '$ref': '#/definitions/type/secure'
              },
              passphrase: {
                '$ref': '#/definitions/type/secure'
              },
              dry_run: {
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
              'bintray'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
