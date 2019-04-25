describe Travis::Yml::Schema::Def::Deploy::Openshift, 'structure' do
  describe 'definitions' do
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
              user: {
                '$ref': '#/definitions/type/secure'
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
            normal: true,
            prefix: :provider,
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
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/deploy/openshift'
      )
    end
  end
end
