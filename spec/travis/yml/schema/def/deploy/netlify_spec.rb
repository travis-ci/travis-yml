describe Travis::Yml::Schema::Def::Deploy::Netlify do
  subject { Travis::Yml.schema[:definitions][:deploy][:netlify] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :netlify,
        title: 'Netlify',
        anyOf: [
          {
            type: :object,
            properties: {
              site: {
                type: :string
              },
              auth: {
                '$ref': '#/definitions/type/secure'
              },
              dir: {
                type: :string
              },
              functions: {
                type: :string
              },
              message: {
                type: :string
              },
              prod: {
                type: :boolean
              },
              provider: {
                type: :string,
                enum: [
                  'netlify'
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
              'netlify'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
