describe Travis::Yml::Schema::Def::Deploy::Pypi, 'schema' do
  subject { Travis::Yml.schema[:definitions][:deploy][:pypi] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :deploy_pypi,
        title: 'Deploy Pypi',
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
                '$ref': '#/definitions/deploy/conditions'
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
              user: {
                '$ref': '#/definitions/type/secure'
              },
              password: {
                '$ref': '#/definitions/type/secure'
              },
              api_key: {
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
              skip_upload_docs: {
                type: :boolean
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
              'pypi'
            ],
            strict: true
          }
        ],
        normal: true
    )
  end
end
