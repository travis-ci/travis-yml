describe Travis::Yaml::Doc::Change::Cache do
  let(:types) { [:apt, :bundler, :cargo, :ccache, :cocoapods, :npm, :packages, :pip, :yarn] }
  let(:cache) { subject.raw[:cache] }

  subject { change(build(nil, :root, value, {})) }

  describe 'given true' do
    let(:value) { { cache: true } }
    it { expect(cache.keys).to eq types }
    it { expect(cache[:apt]).to be true }
  end

  describe 'given a string' do
    let(:value) { { cache: 'foo' } }
    it { expect(cache).to eq directories: ['foo'] }
  end

  describe 'given an array of strings with known types' do
    let(:value) { { cache: ['apt', 'bundler'] } }
    it { expect(cache).to eq apt: true, bundler: true }
  end

  describe 'given an array of strings with a known and an unknown type' do
    let(:value) { { cache: ['apt', 'foo'] } }
    it { expect(cache).to eq apt: true, directories: ['foo'] }
  end

  describe 'given a hash with known keys' do
    let(:value) { { cache: { apt: { packages: 'foo' }, directories: 'foo' } } }
    it { expect(cache).to eq apt: { packages: 'foo' }, directories: ['foo'] }
  end
end
