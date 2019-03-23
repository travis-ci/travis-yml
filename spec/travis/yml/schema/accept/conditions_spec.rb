describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'conditions' do
    it { should validate conditions: 'v0' }
    it { should validate conditions: 'v1' }

    it { should_not validate conditions: 'not-a-version' }
    it { should_not validate conditions: ['v0'] }
    it { should_not validate conditions: [version: 'v0'] }
  end
end
