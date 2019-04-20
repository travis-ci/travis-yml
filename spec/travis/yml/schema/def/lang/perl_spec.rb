describe Travis::Yml::Schema::Def::Perl, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:perl] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :perl,
        title: 'Perl',
        type: :object,
        properties: {
          perl: {
            '$ref': '#/definitions/strs'
          }
        },
        keys: {
          perl: {
            only: {
              language: [
                'perl'
              ]
            }
          }
        },
        normal: true
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/perl'
      )
    end
  end
end
