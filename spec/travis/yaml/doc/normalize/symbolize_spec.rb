describe Travis::Yaml::Doc::Normalize::Symbolize do
  let(:result) { described_class.new(nil, {}, :key, value).apply }

  describe 'given a string' do
    let(:value) { 'foo' }
    it { expect(result).to eq 'foo' }
  end

  describe 'given a hash with string keys' do
    let(:value) { { 'foo' => 'bar' } }
    it { expect(result.keys).to eq [:foo] }
  end

  describe 'given an array with hashes with string keys' do
    let(:value) { [{ 'foo' => 'bar' }] }
    it { expect(result.map(&:keys)).to eq [[:foo]] }
  end

  describe 'given a hash with an array with hashes with string keys' do
    let(:value) { { 'foo' => [{ 'bar' => 'baz' }] } }
    it { expect(result[:foo].map(&:keys)).to eq [[:bar]] }
  end

  describe 'fix broken yaml aliases crap' do
    let(:value) { { true => :foo } }
    it { expect(result).to eq(on: :foo) }
  end
end
