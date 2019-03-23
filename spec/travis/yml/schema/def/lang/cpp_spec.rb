describe Travis::Yml::Schema::Def::Cpp, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:cpp] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :cpp,
        title: 'Cpp',
        type: :object,
        normal: true
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/cpp'
      )
    end
  end
end
