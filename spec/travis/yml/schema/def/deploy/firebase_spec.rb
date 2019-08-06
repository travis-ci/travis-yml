describe Travis::Yml::Schema::Def::Deploy::Firebase do
  subject { Travis::Yml.schema[:definitions][:deploy][:firebase] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :firebase,
        title: 'Firebase',
        anyOf: [
          {
            type: :object,
            properties: {
              project: {
                type: :string
              },
              token: {
                '$ref': '#/definitions/type/secure'
              },
              message: {
                type: :string
              },
              only: {
                type: :string
              },
              provider: {
                type: :string,
                enum: [
                  'firebase'
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
              'firebase'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
