describe Travis::Yml::Schema::Def::Deploy::Elasticbeanstalk, 'schema' do
  subject { Travis::Yml.schema[:definitions][:deploy][:elasticbeanstalk] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_elasticbeanstalk,
        title: 'Deploy Elasticbeanstalk',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'elasticbeanstalk'
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
              access_key_id: {
                '$ref': '#/definitions/type/secure'
              },
              secret_access_key: {
                '$ref': '#/definitions/type/secure'
              },
              region: {
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
              env: {
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
              zip_file: {
                type: :string
              },
              bucket_name: {
                type: :string
              },
              bucket_path: {
                type: :string
              },
              only_create_app_version: {
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
              'elasticbeanstalk'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
