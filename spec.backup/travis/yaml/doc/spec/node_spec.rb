describe Travis::Yaml::Doc::Spec::Map do
  let(:spec) { Travis::Yaml.expanded }
  let(:lang) { spec[:language] }

  describe 'key' do
    it { expect(lang.key).to eq :language }
  end

  describe 'aliases' do
    it { expect(lang.aliases).to eq language: [:lang] }
  end
end
