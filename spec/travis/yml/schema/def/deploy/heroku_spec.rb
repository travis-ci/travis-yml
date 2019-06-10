describe Travis::Yml::Schema::Def::Deploy::Heroku do
  subject { Travis::Yml.schema[:definitions][:deploy][:heroku] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :heroku,
        title: 'Heroku',
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
                '$ref': '#/definitions/deploy/conditions',
                aliases: [
                  :true
                ]
              },
              run: {
                '$ref': '#/definitions/type/strs',
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
                '$ref': '#/definitions/type/secure',
                aliases: [
                  :user
                ]
              },
              password: {
                '$ref': '#/definitions/type/secure'
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
              git: {
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
              'heroku'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
