describe Travis::Yml::Schema::Def::Deploy::Bitballoon do
  subject { Travis::Yml.schema[:definitions][:deploy][:bitballoon] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :bitballoon,
        title: 'Bitballoon',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'bitballoon'
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
              access_token: {
                '$ref': '#/definitions/type/secure'
              },
              site_id: {
                '$ref': '#/definitions/type/secure'
              },
              local_dir: {
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
              'bitballoon'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
