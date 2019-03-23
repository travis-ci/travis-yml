describe Travis::Yml::Doc::Validate, 'format' do
  subject { described_class.apply(build_schema(schema), build_value(value)) }

  describe 'str' do
    let(:schema) { { type: :object, properties: { foo: { type: :string, flags: [:edge] } } } }

    describe 'given a str matching the format' do
      let(:value) { { foo: 'foo' } }
      it { should have_msg [:info, :foo, :edge] }
    end
  end
end
