describe Travis::Yml::Doc::Validate, 'format' do
  subject { described_class.apply(build_schema(schema), build_value(value)) }

  describe 'str' do
    let(:schema) { { type: :string, pattern: 'foo.*' } }

    describe 'given a str matching the format' do
      let(:value) { 'foo bar' }
      it { should_not have_msg }
      it { should serialize_to value }
    end

    describe 'given a str not matching the format' do
      let(:value) { 'bar' }
      it { should have_msg [:error, :root, :invalid_format, format: 'foo.*', value: 'bar']}
      it { should serialize_to nil }
    end
  end
end
