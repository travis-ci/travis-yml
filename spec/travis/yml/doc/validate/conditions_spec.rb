describe Travis::Yml::Doc::Validate, 'conditions', drop: true do
  subject { described_class.apply(build_schema(schema), build_value(value, opts)) }

  let(:schema) { { type: :object, properties: { if: { type: :string } } } }

  describe 'given a valid condition' do
    let(:value) { { if: 'tag = v1.0.0' } }
    it { should serialize_to value }
    it { should_not have_msg }
  end

  describe 'given an empty str' do
    let(:value) { { if: 'and true' } }
    it { should serialize_to empty }
    it { should have_msg [:error, :if, :invalid_condition, condition: 'and true', message: nil] }
  end
end
