describe Travis::Yml::Schema::Def::Perl, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:perl] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_perl,
        title: 'Language Perl',
        type: :object,
        properties: {
          perl: {
            '$ref': '#/definitions/type/strs'
          }
        },
        normal: true,
        keys: {
          perl: {
            only: {
              language: [
                'perl'
              ]
            }
          }
        }
      )
    end
  end
end
