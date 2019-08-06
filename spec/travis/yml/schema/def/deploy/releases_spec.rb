describe Travis::Yml::Schema::Def::Deploy::Releases do
  subject { Travis::Yml.schema[:definitions][:deploy][:releases] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :releases,
        title: 'Releases',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'releases'
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
              username: {
                '$ref': '#/definitions/type/secure',
                strict: false,
                aliases: [
                  :user
                ]
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              api_key: {
                '$ref': '#/definitions/type/secure'
              },
              repo: {
                type: :string
              },
              file: {
                '$ref': '#/definitions/type/strs'
              },
              file_glob: {
                type: :boolean
              },
              overwrite: {
                type: :boolean
              },
              body: {
                type: :string
              },
              draft: {
                type: :boolean
              },
              name: {
                type: :string
              },
              prerelease: {
                type: :boolean
              },
              release_number: {
                type: :string
              },
              tag_name: {
                type: :string
              },
              target_commitish: {
                type: :string
              },
              'preserve-history': {
                type: :boolean
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
              'releases'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
