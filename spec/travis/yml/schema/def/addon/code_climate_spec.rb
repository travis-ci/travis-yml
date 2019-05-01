describe Travis::Yml::Schema::Def::Addon::CodeClimate do
  subject { Travis::Yml.schema[:definitions][:addon][:code_climate] }

  # it { puts JSON.pretty_generate(described_class.new.exports) }

  it do
    should eq(
      '$id': :addon_code_climate,
      title: 'Addon Code Climate',
      normal: true,
      anyOf: [
        {
          type: :object,
          properties: {
            repo_token: {
              '$ref': '#/definitions/type/secure'
            }
          },
          additionalProperties: false,
          prefix: {
            key: :repo_token
          },
          normal: true,
          changes: [
            {
              change: :enable
            }
          ],
        },
        {
          '$ref': '#/definitions/type/secure'
        },
        {
          type: :boolean
        }
      ]
    )
  end
end
