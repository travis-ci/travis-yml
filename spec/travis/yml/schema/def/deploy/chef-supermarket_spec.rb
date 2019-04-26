describe Travis::Yml::Schema::Def::Deploy::ChefSupermarket, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:"chef-supermarket"] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :'deploy_chef-supermarket',
        title: 'Deploy Chef Supermarket',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'chef-supermarket'
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
              user_id: {
                '$ref': '#/definitions/type/secure'
              },
              client_key: {
                '$ref': '#/definitions/type/secure'
              },
              cookbook_category: {
                type: :string
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: :provider,
            required: [
              :provider
            ]
          },
          {
            type: :string,
            enum: [
              'chef-supermarket'
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
        '$ref': '#/definitions/deploy/chef-supermarket'
      )
    end
  end
end
