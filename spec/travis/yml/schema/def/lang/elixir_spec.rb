describe Travis::Yml::Schema::Def::Elixir, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:elixir] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_elixir,
        title: 'Language Elixir',
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
