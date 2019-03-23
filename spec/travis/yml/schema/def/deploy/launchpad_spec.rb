describe Travis::Yml::Schema::Def::Deploy::Launchpad, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:launchpad] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :launchpad,
        title: 'Launchpad',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'launchpad'
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
              slug: {
                type: :string
              },
              oauth_token: {
                '$ref': '#/definitions/secure'
              },
              oauth_token_secret: {
                '$ref': '#/definitions/secure'
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
              :provider,
              :slug,
              :oauth_token,
              :oauth_token_secret
            ]
          },
          {
            type: :string,
            enum: [
              'launchpad'
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
        '$ref': '#/definitions/deploy/launchpad'
      )
    end
  end
end
