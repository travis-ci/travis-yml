describe Travis::Yml::Schema::Def::Php do
  subject { Travis::Yml.schema[:definitions][:language][:php] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :php,
        title: 'Php',
        type: :object,
        properties: {
          php: {
            '$ref': '#/definitions/type/strs',
            flags: [
              :expand
            ],
            only: {
              language: [
                'php'
              ]
            }
          },
          composer_args: {
            type: :string,
            only: {
              language: [
                'php'
              ]
            }
          }
        },
        normal: true
    )
  end
end
