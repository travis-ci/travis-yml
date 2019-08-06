describe Travis::Yml::Schema::Def::Deploy::Gae do
  subject { Travis::Yml.schema[:definitions][:deploy][:gae] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :gae,
        title: 'Gae',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'gae'
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
              project: {
                type: :string
              },
              keyfile: {
                type: :string
              },
              config: {
                type: :string
              },
              version: {
                type: :string
              },
              no_promote: {
                type: :boolean
              },
              no_stop_previous_version: {
                type: :boolean
              },
              default: {
                type: :boolean
              },
              verbosity: {
                type: :string
              },
              docker_build: {
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
              'gae'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
