describe Travis::Yml::Schema::Def::Deploy::Cloudfoundry, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:cloudfoundry] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_cloudfoundry,
        title: 'Deploy Cloudfoundry',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'cloudfoundry'
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
              api: {
                type: :string
              },
              space: {
                type: :string
              },
              key: {
                type: :string
              },
              manifest: {
                type: :string
              },
              skip_ssl_validation: {
                type: :boolean
              },
              app_name: {
                type: :string
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
              'cloudfoundry'
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
        '$ref': '#/definitions/deploy/cloudfoundry'
      )
    end
  end
end
