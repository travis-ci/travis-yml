describe Travis::Yml::Schema::Def::Deploy::Catalyze do
  subject { Travis::Yml.schema[:definitions][:deploy][:catalyze] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :catalyze,
        title: 'Catalyze',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'catalyze'
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
              skip_cleanup: {
                type: :boolean
              },
              edge: {
                '$ref': '#/definitions/deploy/edge'
              },
              target: {
                type: :string
              },
              path: {
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
              'catalyze'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
