describe Travis::Yml::Schema::Def::Perl6 do
  subject { Travis::Yml.schema[:definitions][:language][:perl6] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should include(
      '$id': :perl6,
      title: 'Perl 6',
      summary: instance_of(String),
      see: instance_of(Hash),
      type: :object,
      properties: {
        perl6: {
          '$ref': '#/definitions/type/strs',
          flags: [
            :expand
          ],
          only: {
            language: [
              'perl6'
            ]
          }
        }
      },
      normal: true
    )
  end
end
