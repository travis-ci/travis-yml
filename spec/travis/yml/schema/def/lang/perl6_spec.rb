describe Travis::Yml::Schema::Def::Perl6, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:perl6] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_perl6,
        title: 'Language Perl6',
        type: :object,
        properties: {
          perl6: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        keys: {
          perl6: {
            only: {
              language: [
                'perl6'
              ]
            }
          }
        }
      )
    end
  end
end
