describe Travis::Yml::Schema::Def::C, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:c] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_c,
        title: 'Language C',
        type: :object,
        normal: true
      )
    end
  end
end
