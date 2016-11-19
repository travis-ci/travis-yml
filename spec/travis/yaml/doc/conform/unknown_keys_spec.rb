describe Travis::Yaml::Doc::Conform::UnknownKeys do
  let(:root) { Travis::Yaml.build(foo: 'bar') }

  subject { described_class.new(root) }

  describe 'apply?' do
    it { expect(subject.apply?).to be true }
  end

  describe 'apply' do
    before { subject.apply }

    it { expect(root.serialize).to be_nil }
    it { expect(root.msgs).to include [:error, :root, :unknown_key, 'dropping unknown key :foo ("bar")'] }
  end
end
