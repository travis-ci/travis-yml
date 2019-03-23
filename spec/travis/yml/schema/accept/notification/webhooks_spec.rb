describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:webhooks]) }

  describe 'webhooks' do
    describe 'enabled' do
      it { should validate notifications: { webhooks: { enabled: true } } }
      it { should_not validate notifications: { webhooks: { enabled: 1 } } }
      it { should_not validate notifications: { webhooks: { enabled: :webhooks } } }
      it { should_not validate notifications: { webhooks: { enabled: [:webhooks] } } }
      it { should_not validate notifications: { webhooks: { enabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { webhooks: { enabled: [{:foo=>'foo'}] } } }
    end

    describe 'disabled' do
      it { should validate notifications: { webhooks: { disabled: true } } }
      it { should_not validate notifications: { webhooks: { disabled: 1 } } }
      it { should_not validate notifications: { webhooks: { disabled: :webhooks } } }
      it { should_not validate notifications: { webhooks: { disabled: [:webhooks] } } }
      it { should_not validate notifications: { webhooks: { disabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { webhooks: { disabled: [{:foo=>'foo'}] } } }
    end

    describe 'urls' do
      it { should validate notifications: { webhooks: { urls: :webhooks } } }
      it { should validate notifications: { webhooks: { urls: [:webhooks] } } }
      it { should_not validate notifications: { webhooks: { urls: 1 } } }
      it { should_not validate notifications: { webhooks: { urls: true } } }
      it { should_not validate notifications: { webhooks: { urls: {:foo=>'foo'} } } }
      it { should_not validate notifications: { webhooks: { urls: [{:foo=>'foo'}] } } }
    end

    describe 'on_start' do
      it { should validate notifications: { webhooks: { on_start: 'always' } } }
      it { should_not validate notifications: { webhooks: { on_start: 1 } } }
      it { should_not validate notifications: { webhooks: { on_start: true } } }
    end

    describe 'on_success' do
      it { should validate notifications: { webhooks: { on_success: 'always' } } }
      it { should_not validate notifications: { webhooks: { on_success: 1 } } }
      it { should_not validate notifications: { webhooks: { on_success: true } } }
    end

    describe 'on_failure' do
      it { should validate notifications: { webhooks: { on_failure: 'always' } } }
      it { should_not validate notifications: { webhooks: { on_failure: 1 } } }
      it { should_not validate notifications: { webhooks: { on_failure: true } } }
    end
  end
end
