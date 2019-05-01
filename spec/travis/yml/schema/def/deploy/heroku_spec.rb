describe Travis::Yml::Schema::Def::Deploy::Heroku, 'schema' do
  subject { Travis::Yml.schema[:definitions][:deploy][:heroku] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_heroku,
        title: 'Deploy Heroku',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'heroku'
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
              strategy: {
                type: :string,
                defaults: [
                  {
                    value: 'api'
                  }
                ],
                enum: [
                  'api',
                  'git'
                ]
              },
              buildpack: {
                type: :string
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
              api_key: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*': {
                        '$ref': '#/definitions/type/secure'
                      }
                    }
                  },
                  {
                    '$ref': '#/definitions/type/secure'
                  }
                ]
              },
              username: {
                '$ref': '#/definitions/type/secure'
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              run: {
                '$ref': '#/definitions/type/strs'
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
              'heroku'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
