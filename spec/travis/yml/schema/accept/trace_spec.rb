describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'trace' do
    it { should validate trace: true }
    it { should validate trace: false }

    it { should_not validate trace: 'not-a-condition' }
    it { should_not validate trace: [true] }
    it { should_not validate trace: [on: true] }
  end
end
