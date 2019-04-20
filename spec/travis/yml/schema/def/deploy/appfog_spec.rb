describe Travis::Yml::Schema::Def::Deploy::Appfog, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:appfog] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :appfog,
        title: 'Appfog',
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
                '$ref': '#/definitions/type/deploy_conditions'
              },
              allow_failure: {
                type: :boolean
              },
              skip_cleanup: {
                type: :boolean
              },
              edge: {
                '$ref': '#/definitions/type/deploy_edge'
              },
              user: {
                '$ref': '#/definitions/secure'
              },
              api_key: {
                '$ref': '#/definitions/secure'
              },
              address: {
                '$ref': '#/definitions/strs'
              },
              metadata: {
                type: :string
              },
              after_deploy: {
                '$ref': '#/definitions/strs'
              },
              app: {
                '$ref': '#/definitions/type/app'
              },
              email: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*' => {
                        '$ref': '#/definitions/secure'
                      }
                    }
                  },
                  {
                    '$ref': '#/definitions/secure'
                  }
                ]
              },
              password: {
                anyOf: [
                  {
                    type: :object,
                    patternProperties: {
                      '.*' => {
                        '$ref': '#/definitions/secure'
                      }
                    }
                  },
                  {
                    '$ref': '#/definitions/secure'
                  }
                ]
              }
            },
            normal: true,
            prefix: :provider,
            required: [
              :provider
            ],
            changes: [
              {
                change: :enable
              }
            ]
          },
          {
            type: :string,
            enum: [
              'appfog'
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
        '$ref': '#/definitions/deploy/appfog'
      )
    end
  end
end
