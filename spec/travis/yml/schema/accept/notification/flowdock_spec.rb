describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:flowdock]) }

  describe 'flowdock' do
    describe 'enabled' do
      it { should validate notifications: { flowdock: { enabled: true } } }
      it { should_not validate notifications: { flowdock: { enabled: 1 } } }
      it { should_not validate notifications: { flowdock: { enabled: :flowdock } } }
      it { should_not validate notifications: { flowdock: { enabled: [:flowdock] } } }
      it { should_not validate notifications: { flowdock: { enabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { flowdock: { enabled: [{:foo=>'foo'}] } } }
    end

    describe 'disabled' do
      it { should validate notifications: { flowdock: { disabled: true } } }
      it { should_not validate notifications: { flowdock: { disabled: 1 } } }
      it { should_not validate notifications: { flowdock: { disabled: :flowdock } } }
      it { should_not validate notifications: { flowdock: { disabled: [:flowdock] } } }
      it { should_not validate notifications: { flowdock: { disabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { flowdock: { disabled: [{:foo=>'foo'}] } } }
    end

    describe 'api_token' do
      it { should validate notifications: { flowdock: { api_token: :flowdock } } }
      it { should_not validate notifications: { flowdock: { api_token: 1 } } }
      it { should_not validate notifications: { flowdock: { api_token: true } } }
      it { should_not validate notifications: { flowdock: { api_token: [:flowdock] } } }
      it { should_not validate notifications: { flowdock: { api_token: {:foo=>'foo'} } } }
      it { should_not validate notifications: { flowdock: { api_token: [{:foo=>'foo'}] } } }
    end

    describe 'template' do
      it { should validate notifications: { flowdock: { template: :flowdock } } }
      it { should validate notifications: { flowdock: { template: [:flowdock] } } }
      it { should_not validate notifications: { flowdock: { template: 1 } } }
      it { should_not validate notifications: { flowdock: { template: true } } }
      it { should_not validate notifications: { flowdock: { template: {:foo=>'foo'} } } }
      it { should_not validate notifications: { flowdock: { template: [{:foo=>'foo'}] } } }
    end

    describe 'on_success' do
      it { should validate notifications: { flowdock: { on_success: 'always' } } }
      it { should_not validate notifications: { flowdock: { on_success: 1 } } }
      it { should_not validate notifications: { flowdock: { on_success: true } } }
    end

    describe 'on_failure' do
      it { should validate notifications: { flowdock: { on_failure: 'always' } } }
      it { should_not validate notifications: { flowdock: { on_failure: 1 } } }
      it { should_not validate notifications: { flowdock: { on_failure: true } } }
    end
  end
end
