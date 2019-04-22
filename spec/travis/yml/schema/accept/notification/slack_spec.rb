describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:slack]) }

  describe 'slack' do
    describe 'enabled' do
      it { should validate notifications: { slack: { enabled: true } } }
      it { should_not validate notifications: { slack: { enabled: 1 } } }
      it { should_not validate notifications: { slack: { enabled: :slack } } }
      it { should_not validate notifications: { slack: { enabled: [:slack] } } }
      it { should_not validate notifications: { slack: { enabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { slack: { enabled: [{:foo=>'foo'}] } } }
    end

    describe 'disabled' do
      it { should validate notifications: { slack: { disabled: true } } }
      it { should_not validate notifications: { slack: { disabled: 1 } } }
      it { should_not validate notifications: { slack: { disabled: :slack } } }
      it { should_not validate notifications: { slack: { disabled: [:slack] } } }
      it { should_not validate notifications: { slack: { disabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { slack: { disabled: [{:foo=>'foo'}] } } }
    end

    describe 'rooms' do
      it { should validate notifications: { slack: { rooms: :slack } } }
      it { should validate notifications: { slack: { rooms: [:slack] } } }
      it { should_not validate notifications: { slack: { rooms: 1 } } }
      it { should_not validate notifications: { slack: { rooms: true } } }
      it { should_not validate notifications: { slack: { rooms: {:foo=>'foo'} } } }
      it { should_not validate notifications: { slack: { rooms: [{:foo=>'foo'}] } } }
    end

    describe 'template' do
      it { should validate notifications: { slack: { template: :slack } } }
      it { should validate notifications: { slack: { template: [:slack] } } }
      it { should_not validate notifications: { slack: { template: 1 } } }
      it { should_not validate notifications: { slack: { template: true } } }
      it { should_not validate notifications: { slack: { template: {:foo=>'foo'} } } }
      it { should_not validate notifications: { slack: { template: [{:foo=>'foo'}] } } }
    end

    describe 'on_pull_requests' do
      it { should validate notifications: { slack: { on_pull_requests: true } } }
      it { should_not validate notifications: { slack: { on_pull_requests: 1 } } }
      it { should_not validate notifications: { slack: { on_pull_requests: :slack } } }
      it { should_not validate notifications: { slack: { on_pull_requests: [:slack] } } }
      it { should_not validate notifications: { slack: { on_pull_requests: {:foo=>'foo'} } } }
      it { should_not validate notifications: { slack: { on_pull_requests: [{:foo=>'foo'}] } } }
    end

    describe 'on_success' do
      it { should validate notifications: { slack: { on_success: 'always' } } }
      it { should_not validate notifications: { slack: { on_success: 1 } } }
      it { should_not validate notifications: { slack: { on_success: true } } }
    end

    describe 'on_failure' do
      it { should validate notifications: { slack: { on_failure: 'always' } } }
      it { should_not validate notifications: { slack: { on_failure: 1 } } }
      it { should_not validate notifications: { slack: { on_failure: true } } }
    end
  end
end
