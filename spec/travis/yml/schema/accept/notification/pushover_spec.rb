describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:pushover]) }

  describe 'pushover' do
    describe 'enabled' do
      it { should validate notifications: { pushover: { enabled: true } } }
      it { should_not validate notifications: { pushover: { enabled: 1 } } }
      it { should_not validate notifications: { pushover: { enabled: :pushover } } }
      it { should_not validate notifications: { pushover: { enabled: [:pushover] } } }
      it { should_not validate notifications: { pushover: { enabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { pushover: { enabled: [{:foo=>'foo'}] } } }
    end

    describe 'disabled' do
      it { should validate notifications: { pushover: { disabled: true } } }
      it { should_not validate notifications: { pushover: { disabled: 1 } } }
      it { should_not validate notifications: { pushover: { disabled: :pushover } } }
      it { should_not validate notifications: { pushover: { disabled: [:pushover] } } }
      it { should_not validate notifications: { pushover: { disabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { pushover: { disabled: [{:foo=>'foo'}] } } }
    end

    describe 'api_key' do
      it { should validate notifications: { pushover: { api_key: :pushover } } }
      it { should_not validate notifications: { pushover: { api_key: 1 } } }
      it { should_not validate notifications: { pushover: { api_key: true } } }
      it { should_not validate notifications: { pushover: { api_key: [:pushover] } } }
      it { should_not validate notifications: { pushover: { api_key: {:foo=>'foo'} } } }
      it { should_not validate notifications: { pushover: { api_key: [{:foo=>'foo'}] } } }
    end

    describe 'users' do
      it { should validate notifications: { pushover: { users: :pushover } } }
      it { should validate notifications: { pushover: { users: [:pushover] } } }
      it { should_not validate notifications: { pushover: { users: 1 } } }
      it { should_not validate notifications: { pushover: { users: true } } }
      it { should_not validate notifications: { pushover: { users: {:foo=>'foo'} } } }
      it { should_not validate notifications: { pushover: { users: [{:foo=>'foo'}] } } }
    end

    describe 'template' do
      it { should validate notifications: { pushover: { template: :pushover } } }
      it { should validate notifications: { pushover: { template: [:pushover] } } }
      it { should_not validate notifications: { pushover: { template: 1 } } }
      it { should_not validate notifications: { pushover: { template: true } } }
      it { should_not validate notifications: { pushover: { template: {:foo=>'foo'} } } }
      it { should_not validate notifications: { pushover: { template: [{:foo=>'foo'}] } } }
    end

    describe 'on_success' do
      it { should validate notifications: { pushover: { on_success: 'always' } } }
      it { should_not validate notifications: { pushover: { on_success: 1 } } }
      it { should_not validate notifications: { pushover: { on_success: true } } }
    end

    describe 'on_failure' do
      it { should validate notifications: { pushover: { on_failure: 'always' } } }
      it { should_not validate notifications: { pushover: { on_failure: 1 } } }
      it { should_not validate notifications: { pushover: { on_failure: true } } }
    end
  end
end
