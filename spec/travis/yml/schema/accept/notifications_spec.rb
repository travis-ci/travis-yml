describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'notifications' do
    xit { should validate notifications: false }
    it { should validate notifications: { enabled: true } }
    it { should validate notifications: { disabled: true } }
    it { should validate notifications: { on_start: 'always' } }
    it { should validate notifications: { on_start: 'never' } }
    it { should validate notifications: { on_start: 'change' } }

    it { should_not validate notifications: { foo: 'one' } }
    it { should_not validate notifications: [foo: 'one'] }
  end
end
