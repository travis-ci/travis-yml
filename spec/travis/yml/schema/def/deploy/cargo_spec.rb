describe Travis::Yml::Schema::Def::Deploy::ChefSupermarket do
  subject { Travis::Yml.schema[:definitions][:deploy][:cargo] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :cargo,
        title: 'Cargo',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'cargo'
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
              token: {
                '$ref': '#/definitions/type/secure'
              },
              allow_dirty: {
                type: :boolean,
              },
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
              'cargo'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
