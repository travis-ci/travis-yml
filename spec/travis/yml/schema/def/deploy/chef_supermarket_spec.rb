describe Travis::Yml::Schema::Def::Deploy::ChefSupermarket do
  subject { Travis::Yml.schema[:definitions][:deploy][:chef_supermarket] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :'deploy_chef_supermarket',
        title: 'Deploy Chef Supermarket',
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
                '$ref': '#/definitions/deploy/conditions',
                aliases: [
                  :true
                ]
              },
              run: {
                type: :string
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
              cookbook_name: {
                type: :string
              },
              cookbook_category: {
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
              'chef_supermarket'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
