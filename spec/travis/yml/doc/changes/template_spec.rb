describe Travis::Yml::Doc::Validate::Template do
  subject { described_class.new(build_schema(schema), build_value(value), {}).apply }

  let(:schema) do
    {
      type: :string,
      vars: [
        'known'
      ]
    }
  end

  describe 'given a str' do
    let(:value) { 'str' }
    it { should serialize_to 'str' }
    it { should_not have_msg }
  end

  describe 'given a num' do
    let(:value) { 1 }
    it { should serialize_to 1 }
    it { should_not have_msg }
  end

  describe 'given a str with a known var' do
    let(:value) { '%{known}' }
    it { should serialize_to '%{known}' }
    it { should_not have_msg }
  end

  describe 'given a str with a known var' do
    let(:value) { '%{unknown}' }
    it { should serialize_to '%{unknown}' }
    it { should have_msg [:warn, :root, :unknown_var, var: 'unknown'] }
  end
end
