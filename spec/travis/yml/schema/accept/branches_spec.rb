describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'branches' do
    # TODO Turn a map with a prefix into an Any (like Seq)
    xit { should validate branches: 'master' }
    xit { should validate branches: ['master'] }

    it { should validate branches: { only: 'master' } }
    it { should validate branches: { only: ['master'] } }
    it { should validate branches: { except: 'master' } }
    it { should validate branches: { except: ['master'] } }

    it { should_not validate branches: { only: true } }
    it { should_not validate branches: { only: { name: 'master' } } }
  end
end
