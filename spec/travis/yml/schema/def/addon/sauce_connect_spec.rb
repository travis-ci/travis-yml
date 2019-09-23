describe Travis::Yml::Schema::Def::Addon::SauceConnect do
  subject { Travis::Yml.schema[:definitions][:addon][:sauce_connect] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :sauce_connect,
      title: 'Sauce Connect',
      summary: instance_of(String),
      see: instance_of(Hash),
      normal: true,
      anyOf: [
        {
          type: :object,
          properties: {
            enabled: {
              type: :boolean
            },
            username: {
              '$ref': '#/definitions/type/secure',
              strict: false
            },
            access_key: {
              '$ref': '#/definitions/type/secure'
            },
            direct_domains: {
              type: :string
            },
            tunnel_domains: {
              type: :string
            },
            no_ssl_bump_domains: {
              type: :string
            }
          },
          additionalProperties: false,
          normal: true,
          changes: [
            {
              change: :enable
            }
          ],
        },
        {
          type: :boolean
        }
      ]
    )
  end
end
