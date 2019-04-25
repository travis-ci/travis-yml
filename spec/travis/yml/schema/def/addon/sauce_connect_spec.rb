describe Travis::Yml::Schema::Def::Addon::SauceConnect, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:addon][:sauce_connect] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :addon_sauce_connect,
        title: 'Addon Sauce Connect',
        normal: true,
        anyOf: [
          {
            type: :object,
            properties: {
              enabled: {
                type: :boolean
              },
              username: {
                '$ref': '#/definitions/type/secure'
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

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/addon/sauce_connect'
      )
    end
  end
end
