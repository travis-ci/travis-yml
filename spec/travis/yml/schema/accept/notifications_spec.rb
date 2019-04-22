describe Travis::Yml, 'accept', slow: true do
  subject { described_class.schema }

  describe 'notifications' do
    it { should validate notifications: false }
    it { should validate notifications: { enabled: true } }
    it { should validate notifications: { disabled: true } }
    it { should validate notifications: { on_success: 'always' } }
    it { should validate notifications: { on_success: 'never' } }
    it { should validate notifications: { on_success: 'change' } }

    it { should_not validate notifications: { foo: 'one' } }
    it { should_not validate notifications: [foo: 'one'] }
  end
end
