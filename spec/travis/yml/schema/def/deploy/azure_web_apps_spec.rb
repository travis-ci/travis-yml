describe Travis::Yml::Schema::Def::Deploy::AzureWebApps, 'schema' do
  subject { Travis::Yml.schema[:definitions][:deploy][:azure_web_apps] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_azure_web_apps,
        title: 'Deploy Azure Web Apps',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'azure_web_apps'
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
              site: {
                type: :string
              },
              slot: {
                type: :string
              },
              username: {
                '$ref': '#/definitions/type/secure'
              },
              password: {
                '$ref': '#/definitions/type/secure'
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
              'azure_web_apps'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
