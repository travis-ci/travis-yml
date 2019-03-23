describe Travis::Yml::Schema::Def::Deploy::Heroku, 'structure' do
  describe 'definitions' do
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
                '$ref': '#/definitions/type/app'
              },
              api_key: {
                '$ref': '#/definitions/secure'
              },
              run: {
                '$ref': '#/definitions/strs'
              }
            },
            normal: true,
            prefix: :provider,
            changes: [
              {
                change: :enable
              }
            ],
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
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/deploy/heroku'
      )
    end
  end
end
