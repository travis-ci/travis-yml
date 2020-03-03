describe Travis::Yml::Schema::Def::Deploy::Gleis do
  subject { Travis::Yml.schema[:definitions][:deploy][:gleis] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :gleis,
        title: 'Gleis',
        anyOf: [
          {
            type: :object,
            properties: {
              app: {
                type: :string
              },
              username: {
                type: :string
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              key_name: {
                type: :string
              },
              verbose: {
                type: :boolean
              },
              provider: {
                type: :string,
                enum: [
                  'gleis'
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
              'gleis'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
