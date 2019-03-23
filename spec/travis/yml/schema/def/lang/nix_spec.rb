describe Travis::Yml::Schema::Def::Nix, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:nix] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :nix,
        title: 'Nix',
        type: :object,
        normal: true
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/nix'
      )
    end
  end
end
