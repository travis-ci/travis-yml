describe Travis::Yaml::Doc::Normalize::Cache do
  let(:spec)  { { types: [:foo, :bar]} }
  let(:result) { described_class.new(nil, spec, :key, value).apply }

  describe 'given true' do
    let(:value) { true }
    it { expect(result).to eq foo: true, bar: true }
  end

  describe 'given a string' do
    let(:value) { 'foo' }
    it { expect(result).to eq foo: true }
  end

  describe 'given an array of strings' do
    let(:value) { ['foo', 'bar'] }
    it { expect(result).to eq foo: true, bar: true }
  end

  describe 'given a hash' do
    let(:value) { { foo: :foo } }
    it { expect(result).to eq foo: :foo }
  end
end
