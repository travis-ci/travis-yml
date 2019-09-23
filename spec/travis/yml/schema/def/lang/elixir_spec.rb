describe Travis::Yml::Schema::Def::Elixir do
  subject { Travis::Yml.schema[:definitions][:language][:elixir] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :elixir,
        title: 'Elixir',
        summary: instance_of(String),
        see: instance_of(Hash),
        type: :object,
        properties: {
          elixir: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'elixir'
              ]
            }
          },
          otp_release: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'elixir'
              ]
            }
          }
        },
        normal: true
    )
  end
end
