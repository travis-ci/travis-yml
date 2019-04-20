describe Travis::Yml::Schema::Def::Shell, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:shell] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :shell,
        title: 'Shell',
        type: :object,
        normal: true
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/shell'
      )
    end
  end
end
