describe Travis::Yml::Doc::Change::Secure do
  subject { described_class.new(build_schema(schema), build_value(value)).apply }

  let(:schema) { { anyOf: [{ type: :object, properties: { secure: { type: :string } }, additionalProperties: false }, { type: :string }] } }

  describe 'given a str' do
    let(:value) { 'foo' }
    it { should serialize_to 'foo' }
  end

  describe 'given a num' do
    let(:value) { 1 }
    it { should serialize_to 1 }
  end

  describe 'given a bool' do
    let(:value) { true }
    it { should serialize_to true }
  end

  describe 'given an array of strs' do
    let(:value) { ['str'] }
    it { should serialize_to ['str'] }
  end

  describe 'given an array of nums' do
    let(:value) { [1] }
    it { should serialize_to [1] }
  end

  describe 'given an object' do
    let(:value) { { foo: 'bar' } }
    it { should serialize_to value }
  end

  describe 'given a secure' do
    let(:value) { { secure: 'bar' } }
    it { should serialize_to value }
  end
end
