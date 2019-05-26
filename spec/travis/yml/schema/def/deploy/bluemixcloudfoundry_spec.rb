describe Travis::Yml::Schema::Def::Deploy::BluemixCloudfoundry do
  subject { Travis::Yml.schema[:definitions][:deploy][:bluemixcloudfoundry] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :bluemixcloudfoundry,
        title: 'Bluemixcloudfoundry',
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
              username: {
                '$ref': '#/definitions/type/secure',
                strict: false
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
              'bluemixcloudfoundry'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
