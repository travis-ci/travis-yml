describe Travis::Yaml::Doc::Validate::UnsupportedKey do
  let(:root) { Travis::Yaml.build(language: 'ruby') }
  let(:spec) { Travis::Yaml::Doc::Spec::Scalar.new(nil, opts) }
  let(:node) { build(root, :key, 'value') }

  subject { described_class.new(spec, node, {}) }

  before { subject.apply }

  describe 'only' do
    describe 'given an included language' do
      let(:opts) { { only: { language: 'ruby' } } }
      it { expect(node.value).to eq 'value' }
      it { expect(root.msgs).to be_empty }
    end

    describe 'given a not included language' do
      let(:opts) { { only: { language: 'go' } } }
      it { expect(node.value).to be nil }
      it { expect(root.msgs).to include [:error, :key, :unsupported, on_key: :language, on_value: 'ruby', key: :key, value: 'value'] }
    end
  end

  describe 'except' do
    describe 'given a not excluded language' do
      let(:opts) { { except: { language: 'go' } } }
      it { expect(node.value).to eq 'value' }
      it { expect(root.msgs).to be_empty }
    end

    describe 'given an excluded language' do
      let(:opts) { { except: { language: 'ruby' } } }
      it { expect(node.value).to be nil }
      it { expect(root.msgs).to include [:error, :key, :unsupported, on_key: :language, on_value: 'ruby', key: :key, value: 'value'] }
    end
  end
end
