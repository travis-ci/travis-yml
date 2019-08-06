describe Travis::Yml::Schema::Def::Deploy::Openshift do
  subject { Travis::Yml.schema[:definitions][:deploy][:openshift] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :openshift,
        title: 'Openshift',
        anyOf: [
          {
            type: :object,
            properties: {
              token: {
                '$ref': '#/definitions/type/secure',
              },
              user: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              server: {
                type: :string
              },
              project: {
                type: :string
              },
              app: {
                type: :string
              },
              provider: {
                type: :string,
                enum: [
                  'openshift'
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
              'openshift'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
