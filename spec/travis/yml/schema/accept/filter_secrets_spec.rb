describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'filter_secrets' do
    it { should validate filter_secrets: true }
    it { should validate filter_secrets: false }

    it { should_not validate filter_secrets: 'not-a-boolean' }
    it { should_not validate filter_secrets: [true] }
    it { should_not validate filter_secrets: [on: true] }
  end
end
