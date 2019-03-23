describe Travis::Yml::Schema::Def::C, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:c] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :c,
        title: 'C',
        type: :object,
        normal: true
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/c'
      )
    end
  end
end
