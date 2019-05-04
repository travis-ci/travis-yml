describe Travis::Yml::Doc::Validate, 'format' do
  subject { described_class.apply(build_schema(schema), build_value(value, opts)) }

  describe 'str' do
    let(:schema) { { type: :string, pattern: 'foo.*' } }

    describe 'given a str matching the format' do
      let(:value) { 'foo bar' }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a str not matching the format' do
      let(:value) { 'bar' }

      describe 'drop turned off (default)' do
        it { should serialize_to value }
        it { should have_msg [:error, :root, :invalid_format, format: 'foo.*', value: 'bar']}
      end

      describe 'drop turned on', drop: true do
        it { should serialize_to nil }
        it { should have_msg [:error, :root, :invalid_format, format: 'foo.*', value: 'bar']}
      end
    end
  end
end
