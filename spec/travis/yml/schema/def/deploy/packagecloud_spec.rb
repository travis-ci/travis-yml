describe Travis::Yml::Schema::Def::Deploy::Packagecloud do
  subject { Travis::Yml.schema[:definitions][:deploy][:packagecloud] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :packagecloud,
        title: 'Packagecloud',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'packagecloud'
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
              username: {
                '$ref': '#/definitions/type/secure',
                strict: false
              },
              token: {
                '$ref': '#/definitions/type/secure'
              },
              repository: {
                type: :string
              },
              local_dir: {
                type: :string
              },
              dist: {
                type: :string
              },
              package_glob: {
                type: :string
              },
              force: {
                type: :boolean
              },
              connect_timeout: {
                type: :number
              },
              read_timeout: {
                type: :number
              },
              write_timeout: {
                type: :number
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
              'packagecloud'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
