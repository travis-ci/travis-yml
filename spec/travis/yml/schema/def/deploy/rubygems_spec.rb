describe Travis::Yml::Schema::Def::Deploy::Rubygems, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:rubygems] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_rubygems,
        title: 'Deploy Rubygems',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'rubygems'
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
              gem: {
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
              file: {
                type: :string
              },
              gemspec: {
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
              'rubygems'
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
        '$ref': '#/definitions/deploy/rubygems'
      )
    end
  end
end
