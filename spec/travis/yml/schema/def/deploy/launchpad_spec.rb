describe Travis::Yml::Schema::Def::Deploy::Launchpad, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:launchpad] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_launchpad,
        title: 'Deploy Launchpad',
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
              slug: {
                type: :string
              },
              oauth_token: {
                '$ref': '#/definitions/type/secure'
              },
              oauth_token_secret: {
                '$ref': '#/definitions/type/secure'
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: :provider,
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
        ],
        normal: true
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
