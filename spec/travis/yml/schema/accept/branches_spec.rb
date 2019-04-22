describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'branches' do
    it { should validate branches: 'master' }
    it { should validate branches: ['master'] }

    it { should validate branches: { only: 'master' } }
    it { should validate branches: { only: ['master'] } }
    it { should validate branches: { except: 'master' } }
    it { should validate branches: { except: ['master'] } }

    it { should_not validate branches: { only: true } }
    it { should_not validate branches: { only: { name: 'master' } } }
  end
end
