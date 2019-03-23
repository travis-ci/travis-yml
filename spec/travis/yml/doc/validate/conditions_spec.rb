describe Travis::Yml::Doc::Validate, 'conditions' do
  subject { described_class.apply(build_schema(schema), build_value(value)) }

  let(:schema) { { type: :object, properties: { if: { type: :string } } } }

  describe 'given a valid condition' do
    let(:value) { { if: 'tag = v1.0.0' } }
    it { should_not have_msg }
    it { should serialize_to value }
  end

  describe 'given an empty str' do
    let(:value) { { if: 'and true' } }
    it { should have_msg [:error, :if, :invalid_condition, condition: 'and true'] }
    it { should serialize_to({}) }
  end
end
