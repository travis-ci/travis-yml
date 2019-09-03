describe Travis::Yml::Schema::Def::Deploy::ChefSupermarket do
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
                '$ref': '#/definitions/deploy/conditions',
                aliases: [
                  :true
                ]
              },
              run: {
                '$ref': '#/definitions/type/strs',
              },
              allow_failure: {
                type: :boolean
              },
              cleanup: {
                type: :boolean
              },
              skip_cleanup: {
                type: :boolean,
                deprecated: 'not supported in dpl v2, use cleanup'
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
              name: {
                type: :string,
                aliases: [
                  :cookbook_name
                ]
              },
              category: {
                type: :string,
                aliases: [
                  :cookbook_category
                ]
              },
              dir: {
                type: :string
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :provider,
              only: [
                :str
              ]
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
