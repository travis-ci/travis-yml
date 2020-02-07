describe Travis::Yml::Schema::Def::Addon::Browserstack do
  subject { Travis::Yml.schema[:definitions][:addon][:browserstack] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :browserstack,
      title: 'Browserstack',
      normal: true,
      summary: kind_of(String),
      see: kind_of(Hash),
      anyOf: [
        {
          type: :object,
          properties: {
            username: {
              '$ref': '#/definitions/type/secure',
              summary: 'Browserstack username',
              strict: false
            },
            access_key: {
              '$ref': '#/definitions/type/secure',
              summary: 'Browserstack access key',
            },
            app_path: {
              type: :string,
              summary: 'Path to the app file'
            },
            forcelocal: {
              type: :boolean,
              summary: 'Force all network traffic to be resolved via the build environment VM'
            },
            only: {
              type: :string,
              summary: 'Restrict local testing access to the specified local servers/directories'
            },
            proxyHost: {
              type: :string
            },
            proxyPort: {
              type: :string
            },
            proxyUser: {
              type: :string
            },
            proxyPass: {
              '$ref': '#/definitions/type/secure'
            }
          },
          additionalProperties: false,
          changes: [
            {
              change: :enable
            }
          ],
          normal: true
        },
        {
          type: :boolean
        }
      ]
    )
  end
end
