describe Travis::Yml::Doc::Validate, 'alert' do
  subject { described_class.apply(build_schema(schema), build_value(value, opts)) }

  let(:schema) { Travis::Yml.schema[:definitions][:type][:secure] }

  describe 'with opts[:alert] == true' do
    describe 'given a str' do
      let(:value) { 'str' }
      it { should serialize_to 'str' }
      it { should have_msg [:alert, :root, :secure, given: :str] }
    end

    describe 'given a secure' do
      let(:value) { { secure: 'str' } }
      it { should serialize_to secure: 'str' }
      it { should_not have_msg }
    end
  end
end
