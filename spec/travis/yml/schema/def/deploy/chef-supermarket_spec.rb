describe Travis::Yml::Schema::Def::Deploy::ChefSupermarket do
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
                '$ref': '#/definitions/deploy/conditions',
                aliases: [
                  :true
                ]
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
              'chef-supermarket'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
