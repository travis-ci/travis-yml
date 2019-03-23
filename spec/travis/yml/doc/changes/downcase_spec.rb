describe Travis::Yml::Doc::Change::Downcase do
  subject { described_class.new(build_schema(schema), build_value(value)).apply }

  let(:schema) { { type: :string, downcase: true } }

  describe 'given a downcased str' do
    let(:value) { 'foo' }
    it { should serialize_to 'foo' }
    it { should_not have_msg }
  end

  describe 'given a upcased str' do
    let(:value) { 'FOO' }
    it { should serialize_to 'foo' }
    it { should have_msg [:info, :root, :downcase, value: 'FOO'] }
  end

  describe 'given a num' do
    let(:value) { 1 }
    it { should serialize_to 1 }
    it { should_not have_msg }
  end

  describe 'given a bool' do
    let(:value) { true }
    it { should serialize_to true }
    it { should_not have_msg }
  end

  describe 'given a seq' do
    let(:value) { ['foo'] }
    it { should serialize_to ['foo'] }
    it { should_not have_msg }
  end
end
