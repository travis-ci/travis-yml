describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:hipchat]) }

  describe 'hipchat' do
    describe 'enabled' do
      it { should validate notifications: { hipchat: { enabled: true } } }
      it { should_not validate notifications: { hipchat: { enabled: 1 } } }
      it { should_not validate notifications: { hipchat: { enabled: :hipchat } } }
      it { should_not validate notifications: { hipchat: { enabled: [:hipchat] } } }
      it { should_not validate notifications: { hipchat: { enabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { hipchat: { enabled: [{:foo=>'foo'}] } } }
    end

    describe 'disabled' do
      it { should validate notifications: { hipchat: { disabled: true } } }
      it { should_not validate notifications: { hipchat: { disabled: 1 } } }
      it { should_not validate notifications: { hipchat: { disabled: :hipchat } } }
      it { should_not validate notifications: { hipchat: { disabled: [:hipchat] } } }
      it { should_not validate notifications: { hipchat: { disabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { hipchat: { disabled: [{:foo=>'foo'}] } } }
    end

    describe 'rooms' do
      it { should validate notifications: { hipchat: { rooms: :hipchat } } }
      it { should validate notifications: { hipchat: { rooms: [:hipchat] } } }
      it { should_not validate notifications: { hipchat: { rooms: 1 } } }
      it { should_not validate notifications: { hipchat: { rooms: true } } }
      it { should_not validate notifications: { hipchat: { rooms: {:foo=>'foo'} } } }
      it { should_not validate notifications: { hipchat: { rooms: [{:foo=>'foo'}] } } }
    end

    describe 'format' do
      it { should validate notifications: { hipchat: { format: 'html' } } }
      it { should_not validate notifications: { hipchat: { format: 1 } } }
      it { should_not validate notifications: { hipchat: { format: true } } }
      it { should_not validate notifications: { hipchat: { format: [:hipchat] } } }
      it { should_not validate notifications: { hipchat: { format: {:foo=>'foo'} } } }
      it { should_not validate notifications: { hipchat: { format: [{:foo=>'foo'}] } } }
    end

    describe 'notify' do
      it { should validate notifications: { hipchat: { notify: true } } }
      it { should_not validate notifications: { hipchat: { notify: 1 } } }
      it { should_not validate notifications: { hipchat: { notify: :hipchat } } }
      it { should_not validate notifications: { hipchat: { notify: [:hipchat] } } }
      it { should_not validate notifications: { hipchat: { notify: {:foo=>'foo'} } } }
      it { should_not validate notifications: { hipchat: { notify: [{:foo=>'foo'}] } } }
    end

    describe 'on_pull_requests' do
      it { should validate notifications: { hipchat: { on_pull_requests: true } } }
      it { should_not validate notifications: { hipchat: { on_pull_requests: 1 } } }
      it { should_not validate notifications: { hipchat: { on_pull_requests: :hipchat } } }
      it { should_not validate notifications: { hipchat: { on_pull_requests: [:hipchat] } } }
      it { should_not validate notifications: { hipchat: { on_pull_requests: {:foo=>'foo'} } } }
      it { should_not validate notifications: { hipchat: { on_pull_requests: [{:foo=>'foo'}] } } }
    end

    describe 'template' do
      it { should validate notifications: { hipchat: { template: :hipchat } } }
      it { should validate notifications: { hipchat: { template: [:hipchat] } } }
      it { should_not validate notifications: { hipchat: { template: 1 } } }
      it { should_not validate notifications: { hipchat: { template: true } } }
      it { should_not validate notifications: { hipchat: { template: {:foo=>'foo'} } } }
      it { should_not validate notifications: { hipchat: { template: [{:foo=>'foo'}] } } }
    end

    describe 'on_success' do
      it { should validate notifications: { hipchat: { on_success: 'always' } } }
      it { should_not validate notifications: { hipchat: { on_success: 1 } } }
      it { should_not validate notifications: { hipchat: { on_success: true } } }
    end

    describe 'on_failure' do
      it { should validate notifications: { hipchat: { on_failure: 'always' } } }
      it { should_not validate notifications: { hipchat: { on_failure: 1 } } }
      it { should_not validate notifications: { hipchat: { on_failure: true } } }
    end
  end
end
