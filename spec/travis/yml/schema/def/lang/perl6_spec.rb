describe Travis::Yml::Schema::Def::Perl6, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:perl6] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :perl6,
        title: 'Perl6',
        type: :object,
        properties: {
          perl6: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        only: {
          perl6: {
            language: [
              'perl6'
            ]
          }
        }
      )
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/language/perl6'
  #     )
  #   end
  # end
end
