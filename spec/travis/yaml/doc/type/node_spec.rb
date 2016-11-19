describe Travis::Yaml::Doc::Type::Node do
  let(:root)  { Travis::Yaml.build(language: 'ruby') }
  let(:lang)  { root.children[0] }
  let(:dist)  { root.children[2] }
  let(:node)  { described_class.new(root, :key, value, opts) }
  let(:value) { 'value' }
  let(:opts)  { { alert: true, edge: true, flagged: true, except: { language: 'ruby' } } }

  describe 'root' do
    it { expect(root.root).to eq root }
    it { expect(lang.root).to eq root }
    it { expect(node.root).to eq root }
  end

  describe 'root?' do
    it { expect(root).to     be_root }
    it { expect(lang).not_to be_root }
    it { expect(node).not_to be_root }
  end

  describe 'given?' do
    it { expect(lang).to     be_given }
    it { expect(dist).not_to be_given }
  end

  describe 'known?' do
    it { expect(lang).to     be_known }
    it { expect(node).not_to be_known }
  end

  describe 'default?' do
    it { expect(lang).to     be_default }
    it { expect(node).not_to be_default }
  end

  describe 'default' do
    it { expect(lang.default).to eq(value: 'ruby') }
    it { expect(node.default).to be_nil }
  end

  describe 'alert?' do
    it { expect(lang).to_not be_alert }
    it { expect(node).to     be_alert }
  end

  describe 'relevant?' do
    it { expect(lang).to     be_relevant }
    it { expect(node).to_not be_relevant }
  end

  describe 'present?' do
    it { expect(lang).to     be_present }
    it { expect(dist).to_not be_present }
  end

  describe 'blank?' do
    it { expect(lang).to_not be_blank }
    it { expect(dist).to     be_blank }
  end

  describe 'required?' do
    it { expect(lang).to     be_required }
    it { expect(node).to_not be_required }
  end

  describe 'edge?' do
    it { expect(lang).to_not be_edge }
    it { expect(node).to     be_edge }
  end

  describe 'flagged?' do
    it { expect(lang).to_not be_flagged }
    it { expect(node).to     be_flagged }
  end
end
