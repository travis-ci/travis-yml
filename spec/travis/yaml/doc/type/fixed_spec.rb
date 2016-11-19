describe Travis::Yaml::Doc::Type::Fixed do
  let(:root)  { Travis::Yaml.build(language: 'jvm') }
  let(:lang)  { root.children[0] }
  let(:node)  { described_class.new(root, :key, 'value', { values: [value: 'value'] }) }
  let(:java)  { lang.values.detect { |value| value.to_s == 'java' } }

  describe 'values' do
    it { expect(lang.values.size).to eq 29 }
    it { expect(node.values.size).to eq 1 }
    it { expect(java.to_s).to eq 'java' }
    it { expect(java.alias_for?('jvm')).to be true }
  end

  describe 'alias' do
    it { expect(lang.alias).to eq 'java' }
    it { expect(node.alias).to be_nil }
  end
end
