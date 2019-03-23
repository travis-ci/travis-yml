describe Travis::Yml, 'unknown_value' do
  let(:empty) { {} }

  subject { described_class.apply(value) }

  describe 'given a known value' do
    let(:value) { { git: { strategy: 'clone' } } }
    it { should serialize_to git: { strategy: 'clone' } }
    it { should_not have_msg }
  end

  describe 'given an unknown value' do
    let(:value) { { git: { strategy: 'foo' } } }
    it { should serialize_to empty }
    it { should have_msg [:error, :'git.strategy', :unknown_value, value: 'foo'] }
  end
end
