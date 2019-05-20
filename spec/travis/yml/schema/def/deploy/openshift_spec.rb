describe Travis::Yml::Schema::Def::Deploy::Openshift do
  subject { Travis::Yml.schema[:definitions][:deploy][:openshift] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_openshift,
        title: 'Deploy Openshift',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'openshift'
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
              user: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              domain: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*': {
                        type: :string
                      }
                    }
                  },
                  {
                    type: :string
                  }
                ]
              },
              app: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*': {
                        type: :string
                      }
                    }
                  },
                  {
                    type: :string
                  }
                ]
              },
              deployment_branch: {
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
              'openshift'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
