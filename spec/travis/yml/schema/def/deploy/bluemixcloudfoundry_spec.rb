describe Travis::Yml::Schema::Def::Deploy::BluemixCloudfoundry, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:bluemixcloudfoundry] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_bluemixcloudfoundry,
        title: 'Deploy Bluemixcloudfoundry',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'bluemixcloudfoundry'
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
              region: {
                type: :string
              },
              manifest: {
                type: :string
              },
              skip_ssl_validation: {
                type: :boolean
              }
            },
            normal: true,
            prefix: :provider,
            required: [
              :provider
            ]
          },
          {
            type: :string,
            enum: [
              'bluemixcloudfoundry'
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
        '$ref': '#/definitions/deploy/bluemixcloudfoundry'
      )
    end
  end
end
