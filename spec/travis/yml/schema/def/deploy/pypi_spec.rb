describe Travis::Yml::Schema::Def::Deploy::Pypi do
  subject { Travis::Yml.schema[:definitions][:deploy][:pypi] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :pypi,
        title: 'Pypi',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'pypi'
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
              server: {
                type: :string
              },
              distributions: {
                type: :string
              },
              docs_dir: {
                type: :string
              },
              skip_existing: {
                type: :boolean
              },
              upload_docs: {
                type: :boolean
              },
              twine_check: {
                type: :boolean
              },
              remove_build_dir: {
                type: :boolean
              },
              setuptools_version: {
                type: :string
              },
              twine_version: {
                type: :string
              },
              wheel_version: {
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
              'pypi'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
