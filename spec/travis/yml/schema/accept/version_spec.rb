describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'version' do
    it { should validate version: '= 0' }
    it { should validate version: '~> 1.0.0' }

    it { should_not validate version: 'not-a-version' }
    it { should_not validate version: ['= 0'] }
    it { should_not validate version: [number: '= 0'] }
  end
end
