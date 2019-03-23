describe Travis::Yaml, 'cache' do
  let(:cache) { subject.serialize[:cache] }
  let(:types) { Travis::Yaml::Spec::Def::Cache::TYPES }

  subject { described_class.apply(config) }

  describe 'given true' do
    let(:config) { { cache: true } }
    it { expect(cache).to eq types.map { |type| [type, true] }.to_h }
    it { expect(msgs).to be_empty }
  end

  describe 'given false' do
    let(:config) { { cache: false } }
    it { expect(cache).to eq types.map { |type| [type, false] }.to_h }
    it { expect(msgs).to be_empty }
  end

  describe 'given a string' do
    let(:config) { { cache: 'apt' } }
    it { expect(cache).to eq(apt: true) }
    it { expect(msgs).to be_empty }
  end

  describe 'given a string with a typo' do
    let(:config) { { cache: ':apt' } }
    it { expect(cache).to eq(apt: true) }
    it { expect(msgs).to include [:warn, :cache, :clean_value, original: ':apt', value: :apt] }
  end

  describe 'given an unknown string' do
    let(:config) { { cache: 'foo' } }
    it { expect(cache).to eq directories: ['foo'] }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array of known values' do
    let(:config) { { cache: ['apt', 'bundler'] } }
    it { expect(cache).to eq(apt: true, bundler: true) }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array of known values and directories' do
    let(:config) { { cache: ['apt', directories: ['foo']] } }
    it { expect(cache).to eq(apt: true, directories: ['foo']) }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array with a hash with a known type' do
    let(:config) { { cache: ['apt' => true] } }
    it { expect(cache).to eq(apt: true) }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array with a directory hash' do
    let(:config) { { cache: ['directories' => 'foo'] } }
    it { expect(cache).to eq(directories: ['foo']) }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array of unknown values' do
    let(:config) { { cache: ['foo', 'bar'] } }
    it { expect(cache).to eq(directories: ['foo', 'bar']) }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array of mixed known and unknown values' do
    let(:config) { { cache: ['apt', 'foo', 'bar'] } }
    it { expect(cache).to eq(apt: true, directories: ['foo', 'bar']) }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array of mixed known and nonsense hashes' do
    let(:config) { { cache: [{ apt: true }, { http: true }] } }
    it { expect(cache).to eq(apt: true) }
    it { expect(msgs).to include [:error, :cache, :unknown_key, key: :http, value: true] }
  end

  describe 'given a hash' do
    let(:config) { { cache: { 'bundler' => true } } }
    it { expect(cache).to eq(bundler: true) }
    it { expect(msgs).to be_empty }
  end

  describe 'directories' do
    describe 'given a string' do
      let(:config) { { cache: { directories: 'foo' } } }
      it { expect(cache).to eq(directories: ['foo']) }
      it { expect(msgs).to be_empty }
    end

    describe 'given an array' do
      let(:config) { { cache: { directories: ['foo'] } } }
      it { expect(cache).to eq(directories: ['foo']) }
      it { expect(msgs).to be_empty }
    end

    describe 'mixed with a known type' do
      let(:config) { { cache: { bundler: true, directories: ['foo'] } } }
      it { expect(cache).to eq bundler: true, directories: ['foo'] }
      it { expect(msgs).to be_empty }
    end
  end

  describe 'directory (alias)' do
    let(:config) { { cache: { directory: 'foo' } } }
    it { expect(cache).to eq(directories: ['foo']) }
    it { expect(msgs).to include [:warn, :cache, :find_key, original: :directory, key: :directories] }
  end

  describe 'branch' do
    let(:config) { { cache: { branch: 'md5deep' } } }
    it { expect(cache).to eq branch: 'md5deep' }
  end

  describe 'edge' do
    describe 'given a bool' do
      let(:config) { { cache: { edge: true } } }
      it { expect(cache).to eq(edge: true) }
      it { expect(msgs).to be_empty }
    end

    describe 'given a string' do
      let(:config) { { cache: { edge: 'true' } } }
      it { expect(cache).to eq(edge: true) }
      it { expect(info).to include [:info, :'cache.edge', :cast, given_value: 'true', given_type: :str, value: true, type: :bool] }
    end
  end
end
