describe Travis::Yml::Schema::Def::Deploy::Pages do
  subject { Travis::Yml.schema[:definitions][:deploy][:pages] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :pages,
        title: 'Pages',
        anyOf: [
          {
            type: :object,
            properties: {
              provider: {
                type: :string,
                enum: [
                  'pages'
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
              github_token: {
                '$ref': '#/definitions/type/secure'
              },
              repo: {
                type: :string
              },
              target_branch: {
                type: :string
              },
              local_dir: {
                type: :string
              },
              fqdn: {
                type: :string
              },
              project_name: {
                type: :string
              },
              email: {
                type: :string
              },
              name: {
                type: :string
              },
              github_url: {
                type: :string
              },
              no_keep_history: {
                type: :boolean
              },
              verbose: {
                type: :boolean
              },
              allow_empty_commit: {
                type: :boolean
              },
              committer_from_gh: {
                type: :boolean
              },
              deployment_file: {
                type: :boolean
              },
              detect_encoding: {
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
              'pages'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
