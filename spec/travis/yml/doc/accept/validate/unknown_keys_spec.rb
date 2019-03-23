describe Travis::Yml, 'unknown_keys' do
  subject { described_class.apply(value) }

  describe 'given a known key' do
    let(:value) { { language: 'ruby' } }
    it { should serialize_to language: 'ruby' }
    it { should_not have_msg }
  end

  describe 'given an unknown key' do
    let(:value) { { foo: 'foo' } }
    it { should serialize_to foo: 'foo' }
    it { should have_msg [:warn, :root, :unknown_key, key: :foo, value: 'foo'] }
  end
end
