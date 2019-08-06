describe Travis::Yml::Schema::Def::Deploy::Datica do
  subject { Travis::Yml.schema[:definitions][:deploy][:datica] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :datica,
        title: 'Datica',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'datica'
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
              'datica'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
