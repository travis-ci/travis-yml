describe Travis::Yaml::Doc::Type::Seq do
  let(:root)  { Travis::Yaml.build(os: 'osx') }
  let(:os)    { root.children[1] }
  let(:node)  { described_class.new(root, :key, [], {}) }

  describe 'present?' do
    it { expect(os).to       be_present }
    it { expect(node).to_not be_present }
  end

  describe 'error' do
    before { node.error :alert }
    it { expect(root.msgs).to_not be_empty }
    it { expect(node.present?).to be false }
  end
end
