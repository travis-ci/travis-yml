describe Travis::Yaml::Doc::Normalize::Secure do
  let(:result) { described_class.new(nil, {}, :key, value).apply }

  describe 'given true' do
    let(:value) { true }
    it { expect(result).to eq true }
  end

  describe 'given a hash' do
    let(:value) { { foo: 'foo' } }
    it { expect(result).to eq foo: 'foo' }
  end

  describe 'given a secure hash' do
    let(:value) { { secure: 'foo' } }
    it { expect(result).to eq secure: 'foo' }
    it { expect(result).to be_secure }
  end

  describe 'given an array with a secure hash' do
    let(:value) { ['foo', { bar: 'bar' }, { secure: 'baz' }] }
    it { expect(result).to eq ['foo', { bar: 'bar' }, { secure: 'baz' }] }
    it { expect(result.last).to be_secure }
  end

  describe 'given a hash with a nested secure hash' do
    let(:value) { { foo: { bar: { secure: 'baz' } } } }
    it { expect(result).to eq foo: { bar: { secure: 'baz' } } }
    it { expect(result[:foo][:bar]).to be_secure }
  end
end
