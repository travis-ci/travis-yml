describe Travis::Yaml, 'cache' do
  let(:msgs)  { subject.msgs }
  let(:cache) { subject.to_h[:cache] }
  let(:types) { Travis::Yaml::Spec::Def::Cache::TYPES }

  subject { described_class.apply(config) }

  describe 'given true' do
    let(:config) { { cache: true } }
    it { expect(cache).to eq types.map { |type| [type, true] }.to_h }
  end

  describe 'given false' do
    let(:config) { { cache: false } }
    it { expect(cache).to eq types.map { |type| [type, false] }.to_h }
  end

  describe 'given a string' do
    let(:config) { { cache: 'apt' } }
    it { expect(cache).to eq(apt: true) }
  end

  describe 'given an array' do
    let(:config) { { cache: ['apt', 'bundler'] } }
    it { expect(cache).to eq(apt: true, bundler: true) }
  end

  describe 'given a hash' do
    let(:config) { { cache: { bundler: true } } }
    it { expect(cache).to eq(bundler: true) }
  end

  describe 'directories' do
    describe 'given a string' do
      let(:config) { { cache: { directories: 'foo' } } }
      it { expect(cache).to eq(directories: ['foo']) }
    end

    describe 'given an array' do
      let(:config) { { cache: { directories: ['foo'] } } }
      it { expect(cache).to eq(directories: ['foo']) }
    end
  end

  describe 'edge' do
    describe 'given a bool' do
      let(:config) { { cache: { edge: true } } }
      it { expect(cache).to eq(edge: true) }
    end

    describe 'given a string' do
      let(:config) { { cache: { edge: 'true' } } }
      it { expect(cache).to eq(edge: true) }
      # it { expect(msgs).to include [:warn, :'cache.edge', :cast, 'casting value "true" to true (:bool)'] }
    end
  end
end
