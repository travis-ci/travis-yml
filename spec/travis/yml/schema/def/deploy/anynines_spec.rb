describe Travis::Yml::Schema::Def::Deploy::Anynines, 'schema' do
  subject { Travis::Yml.schema[:definitions][:deploy][:anynines] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_anynines,
        title: 'Deploy Anynines',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'anynines'
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
                '$ref': '#/definitions/type/secure'
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              organization: {
                type: :string
              },
              space: {
                type: :string
              },
              app_name: {
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
              'anynines'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
