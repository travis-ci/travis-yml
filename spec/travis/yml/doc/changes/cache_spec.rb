describe Travis::Yml::Doc::Change::Cache do
  subject { described_class.new(build_schema(schema), build_value(value)).apply }

  let(:schema) do
    {
      type: :object,
      properties: {
        apt: {
          type: :boolean
        },
        bundler: {
          type: :boolean
        },
        cargo: {
          type: :boolean
        },
        directories: {
          type: :array,
          items: {
            type: :string
          }
        }
      },
      changes: [
        {
          change: :cache
        }
      ]
    }
  end

  describe 'given true' do
    let(:value) { true }
    it { should serialize_to apt: true, bundler: true, cargo: true }
    it { should have_msg [:warn, :root, :deprecated, deprecation: :cache_enable_all, value: true] }
  end

  describe 'given apt' do
    let(:value) { 'apt' }
    it { should serialize_to apt: true }
    it { should_not have_msg }
  end

  describe 'given true on apt' do
    let(:value) { { apt: true } }
    it { should serialize_to apt: true }
    it { should_not have_msg }
  end

  describe 'given a seq of strs on directories' do
    let(:value) { { directories: ['str'] } }
    it { should serialize_to directories: ['str'] }
    it { should_not have_msg }
  end

  describe 'given a seq with apt and bundler' do
    let(:value) { [:apt, :bundler] }
    it { should serialize_to apt: true, bundler: true }
    it { should_not have_msg }
  end

  describe 'given a seq with apt and directories' do
    let(:value) { [:apt, directories: ['str']] }
    it { should serialize_to apt: true, directories: ['str'] }
    it { should_not have_msg }
  end

  describe 'given a seq with apt and directories' do
    let(:value) { [:apt, directories: ['str']] }
    it { should serialize_to apt: true, directories: ['str'] }
    it { should_not have_msg }
  end

  describe 'given a seq with apt, directories, and an unknown str' do
    let(:value) { [:apt, :unknown, directories: ['str']] }
    it { should serialize_to apt: true, directories: ['str', 'unknown'] }
    it { should_not have_msg }
  end

  describe 'given a seq with apt, directories, and an unknown str in a seq' do
    let(:value) { [:apt, [:unknown], directories: ['str']] }
    it { should serialize_to apt: true, directories: ['str', ['unknown']] }
    it { should_not have_msg }
  end

  describe 'given a seq with apt, directories, and an unknown key with a str' do
    let(:value) { [:apt, directories: ['str'], unknown: 'str'] }
    it { should serialize_to apt: true, directories: ['str'], unknown: 'str' }
    it { should_not have_msg }
  end

  describe 'given a seq with a map apt: true, bundler: true' do
    let(:value) { [apt: true, bundler: true] }
    it { should serialize_to apt: true, bundler: true }
    it { should_not have_msg }
  end

  describe 'given a seq with two maps apt: true, and bundler: true' do
    let(:value) { [{ apt: true }, { bundler: true }] }
    it { should serialize_to apt: true, bundler: true }
    it { should_not have_msg }
  end

  describe 'given a seq with a map apt: true, bundler: true' do
    let(:value) { [apt: true, directories: ['str']] }
    it { should serialize_to apt: true, directories: ['str'] }
    it { should_not have_msg }
  end

  describe 'given a seq with two maps apt: true, and directories' do
    let(:value) { [{ apt: true }, { directories: ['str'] }] }
    it { should serialize_to apt: true, directories: ['str'] }
    it { should_not have_msg }
  end

  describe 'given a seq with two maps with directories, and an unknown str' do
    let(:value) { [{ apt: true, directories: ['foo'] }, { directories: ['bar'] }, 'unknown'] }
    it { should serialize_to apt: true, directories: ['foo', 'bar', 'unknown'] }
    it { should_not have_msg }
  end

  describe 'given a seq with a map on directories' do
    let(:value) { [directories: ['str', foo: 'bar']] }
    it { should serialize_to directories: ['str', foo: 'bar'] }
    it { should_not have_msg }
  end
end
