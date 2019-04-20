describe Travis::Yml::Schema::Def::Deploy::ChefSupermarket, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:chef_supermarket] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :chef_supermarket,
        title: 'Chef Supermarket',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'chef_supermarket'
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
              user_id: {
                '$ref': '#/definitions/secure'
              },
              client_key: {
                '$ref': '#/definitions/secure'
              },
              cookbook_category: {
                type: :string
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
              'chef_supermarket'
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
        '$ref': '#/definitions/deploy/chef_supermarket'
      )
    end
  end
end
