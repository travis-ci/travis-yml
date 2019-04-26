describe Travis::Yml::Schema::Def::Deploy::AzureWebApps, 'structure' do
  describe 'definitions' do
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
            prefix: :provider,
            required: [
              :provider
            ],
            normal: true
          },
          {
            type: :string,
            enum: [
              'azure_web_apps'
            ],
            strict: true
          }
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/deploy/azure_web_apps'
      )
    end
  end
end
