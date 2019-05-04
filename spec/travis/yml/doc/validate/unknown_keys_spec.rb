describe Travis::Yml::Doc::Validate, 'unknown_keys' do
  subject { described_class.apply(build_schema(schema), build_value(value, opts)) }

  let(:schema) { { type: :object, properties: { foo: { type: :string } }, additionalProperties: false } }

  describe 'given a known key' do
    let(:value) { { foo: 'bar' } }
    it { should serialize_to foo: 'bar'  }
    it { should_not have_msg }
  end

  describe 'given an unknown key' do
    let(:value) { { bar: 'bar' } }

    describe 'drop turned off (default)' do
      it { should serialize_to value }
      it { should have_msg [:warn, :root, :unknown_key, key: 'bar', value: 'bar'] }
    end

    describe 'drop turned off on', drop: true do
      it { should serialize_to empty }
      it { should have_msg [:warn, :root, :unknown_key, key: 'bar', value: 'bar'] }
    end
  end
end
