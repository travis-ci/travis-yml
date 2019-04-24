describe Travis::Yml::Schema::Def::Deploy::Releases, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:releases] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :deploy_releases,
        title: 'Deploy Releases',
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
                '$ref': '#/definitions/secure'
              },
              password: {
                '$ref': '#/definitions/secure'
              },
              api_key: {
                '$ref': '#/definitions/secure'
              },
              repo: {
                type: :string
              },
              file: {
                '$ref': '#/definitions/strs'
              },
              file_glob: {
                type: :boolean
              },
              overwrite: {
                type: :boolean
              },
              release_number: {
                type: :string
              },
              prerelease: {
                type: :boolean
              }
            },
            normal: true,
            prefix: :provider,
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
        ]
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/deploy/releases'
      )
    end
  end
end
