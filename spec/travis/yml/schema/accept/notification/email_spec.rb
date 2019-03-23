describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:email]) }

  describe 'email' do
    describe 'enabled' do
      it { should validate notifications: { email: { enabled: true } } }
      it { should_not validate notifications: { email: { enabled: 1 } } }
      it { should_not validate notifications: { email: { enabled: :email } } }
      it { should_not validate notifications: { email: { enabled: [:email] } } }
      it { should_not validate notifications: { email: { enabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { email: { enabled: [{:foo=>'foo'}] } } }
    end

    describe 'disabled' do
      it { should validate notifications: { email: { disabled: true } } }
      it { should_not validate notifications: { email: { disabled: 1 } } }
      it { should_not validate notifications: { email: { disabled: :email } } }
      it { should_not validate notifications: { email: { disabled: [:email] } } }
      it { should_not validate notifications: { email: { disabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { email: { disabled: [{:foo=>'foo'}] } } }
    end

    describe 'recipients' do
      it { should validate notifications: { email: { recipients: :email } } }
      it { should validate notifications: { email: { recipients: [:email] } } }
      it { should_not validate notifications: { email: { recipients: 1 } } }
      it { should_not validate notifications: { email: { recipients: true } } }
      it { should_not validate notifications: { email: { recipients: {:foo=>'foo'} } } }
      it { should_not validate notifications: { email: { recipients: [{:foo=>'foo'}] } } }
    end

    describe 'on_start' do
      it { should validate notifications: { email: { on_start: 'always' } } }
      it { should_not validate notifications: { email: { on_start: 1 } } }
      it { should_not validate notifications: { email: { on_start: true } } }
    end

    describe 'on_success' do
      it { should validate notifications: { email: { on_success: 'always' } } }
      it { should_not validate notifications: { email: { on_success: 1 } } }
      it { should_not validate notifications: { email: { on_success: true } } }
    end

    describe 'on_failure' do
      it { should validate notifications: { email: { on_failure: 'always' } } }
      it { should_not validate notifications: { email: { on_failure: 1 } } }
      it { should_not validate notifications: { email: { on_failure: true } } }
    end
  end
end
