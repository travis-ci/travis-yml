describe Travis::Yml::Schema::Def::Deploy::Modulus, 'schema' do
  subject { Travis::Yml.schema[:definitions][:deploy][:modulus] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_modulus,
        title: 'Deploy Modulus',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'modulus'
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
              api_key: {
                '$ref': '#/definitions/type/secure'
              },
              project_name: {
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
              'modulus'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
