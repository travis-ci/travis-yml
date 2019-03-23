describe Travis::Yml::Doc::Validate, 'unknown_keys' do
  subject { described_class.apply(build_schema(schema), build_value(value)) }

  describe 'map' do
    let(:schema) { { type: :object, properties: { foo: { type: :string } }, additionalProperties: false } }

    describe 'given a known key' do
      let(:value) { { foo: 'bar' } }
      it { should_not have_msg }
      it { should serialize_to foo: 'bar'  }
    end

    describe 'given an unknown key' do
      let(:value) { { bar: 'bar' } }
      it { should have_msg [:warn, :root, :unknown_key, key: :bar, value: 'bar'] }
      it { should serialize_to bar: 'bar' }
    end
  end
end
