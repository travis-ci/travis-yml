describe Travis::Yml::Doc::Value, 'factory' do
  subject { described_class::Factory.build(nil, :key, value, {}) }

  describe 'given nil' do
    let(:value) { nil }
    it { should be_none }
    it { should serialize_to value }
  end

  describe 'given true' do
    let(:value) { true }
    it { should be_bool }
    it { should serialize_to value }
  end

  describe 'given false' do
    let(:value) { false }
    it { should be_bool }
    it { should serialize_to value }
  end

  describe 'given an integer' do
    let(:value) { 1 }
    it { should be_num }
    it { should serialize_to value }
  end

  describe 'given a float' do
    let(:value) { 1.0 }
    it { should be_num }
    it { should serialize_to value }
  end

  describe 'given a string' do
    let(:value) { 'foo' }
    it { should be_str }
    it { should serialize_to value }
  end

  describe 'given a symbol' do
    let(:value) { :foo }
    it { should be_str }
    it { should serialize_to 'foo' }
  end

  describe 'given an array' do
    let(:value) { [1, :foo, bar: :baz] }
    it { should be_seq }
    it { should serialize_to [1, 'foo', bar: 'baz'] }
  end

  describe 'given a hash' do
    let(:value) { { foo: :bar } }
    it { should be_map }
    it { should serialize_to foo: 'bar' }
  end

  describe 'given a secure' do
    let(:value) { { 'secure' => 'secure' } }
    it { should be_secure }
    it { should serialize_to secure: 'secure' }
  end

  describe 'given a hash with anchors' do
    let(:value) { Map.new({ foo: :bar }, anchors: ['baz']) }
    it { should be_map }
    it { should serialize_to foo: 'bar' }
    it { should have_attributes anchors: ['baz'] }
  end
end
