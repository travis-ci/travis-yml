describe Travis::Yml::Doc::Validate, 'required', defaults: true do
  subject { described_class.apply(build_schema(schema), build_value(value, opts)) }

  describe 'str' do
    let(:schema) do
      {
        type: :object,
        properties: {
          foo: {
            type: :string
          },
          bar: {
            type: :string
          }
        },
        required: [
          :foo
        ]
      }
    end

    describe 'given a map with the required key' do
      let(:value) { { foo: 'foo', bar: 'bar' } }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a map without the required key' do
      let(:value) { { bar: 'bar' } }
      it { should serialize_to empty }
      it { should have_msg [:error, :root, :required, key: 'foo']}
    end

    describe 'given a map with the required key being nil' do
      let(:value) { { foo: nil, bar: 'bar' } }
      it { should serialize_to empty }
      it { should have_msg [:error, :root, :required, key: 'foo']}
    end
  end
end
