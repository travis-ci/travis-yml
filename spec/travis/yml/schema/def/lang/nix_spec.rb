describe Travis::Yml::Schema::Def::Nix, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:nix] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :language_nix,
        title: 'Language Nix',
        type: :object,
        normal: true
      )
    end
  end
end
