describe Travis::Yml::Schema::Def::Deploy::Appfog do
  subject { Travis::Yml.schema[:definitions][:deploy][:appfog] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_appfog,
        title: 'Deploy Appfog',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'appfog'
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
              api_key: {
                '$ref': '#/definitions/type/secure'
              },
              address: {
                '$ref': '#/definitions/type/strs'
              },
              metadata: {
                type: :string
              },
              after_deploy: {
                '$ref': '#/definitions/type/strs'
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
              email: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*' => {
                        '$ref': '#/definitions/type/secure'
                      }
                    }
                  },
                  {
                    '$ref': '#/definitions/type/secure'
                  }
                ]
              },
              password: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*' => {
                        '$ref': '#/definitions/type/secure'
                      }
                    }
                  },
                  {
                    '$ref': '#/definitions/type/secure'
                  }
                ]
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
              'appfog'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
