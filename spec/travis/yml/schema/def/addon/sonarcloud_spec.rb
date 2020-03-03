describe Travis::Yml::Schema::Def::Addon::Sonarcloud do
  subject { Travis::Yml.schema[:definitions][:addon][:sonarcloud] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :sonarcloud,
      title: 'Sonarcloud',
      summary: kind_of(String),
      see: kind_of(Hash),
      anyOf: [
        {
          type: :object,
          properties: {
            enabled: {
              type: :boolean
            },
            organization: {
              type: :string
            },
            token: {
              '$ref': '#/definitions/type/secure'
            },
            github_token: {
              '$ref': '#/definitions/type/secure',
              deprecated: 'setting a GitHub token is deprecated'
            },
            branches: {
              '$ref': '#/definitions/type/strs',
              deprecated: 'setting a branch is deprecated'
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
      ],
      normal: true,
    )
  end
end
