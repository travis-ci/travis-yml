describe Travis::Yaml::Doc::Conform::Cast do
  let(:msgs) { root.msgs }
  let(:root) { Travis::Yaml.build(language: 'ruby') }
  let(:node) { Travis::Yaml::Doc::Type::Scalar.new(root, :key, value, opts) }
  let(:opts) { { cast: cast } }
  let(:cast) { [:str] }

  subject { described_class.new(node) }

  describe 'given a string' do
    let(:value) { 'foo' }

    describe 'apply?' do
      it { expect(subject.apply?).to be false }
    end
  end

  describe 'given a bool' do
    let(:value) { true }

    describe 'apply?' do
      it { expect(subject.apply?).to be true }
    end

    describe 'apply' do
      before { subject.apply }
      it { expect(node.value).to eq 'true' }
      # it { expect(msgs).to include [:info, :key, :cast, 'casting value true to "true" (:str)'] }
    end
  end

  describe 'given :secure' do
    let(:cast) { [:secure] }

    describe 'given a string' do
      let(:value) { 'foo' }
      it { expect(node.value).to eq value }
      it { expect(msgs).to be_empty }
    end

    describe 'given a secure string' do
      let(:value) { Travis::Yaml::Doc::Secure.new(secure: 'foo') }
      it { expect(node.value).to eq value }
      it { expect(msgs).to be_empty }
    end
  end
end
