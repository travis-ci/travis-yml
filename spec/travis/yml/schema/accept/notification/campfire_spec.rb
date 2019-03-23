describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:campfire]) }

  describe 'campfire' do
    describe 'enabled' do
      it { should validate notifications: { campfire: { enabled: true } } }
      it { should_not validate notifications: { campfire: { enabled: 1 } } }
      it { should_not validate notifications: { campfire: { enabled: :campfire } } }
      it { should_not validate notifications: { campfire: { enabled: [:campfire] } } }
      it { should_not validate notifications: { campfire: { enabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { campfire: { enabled: [{:foo=>'foo'}] } } }
    end

    describe 'disabled' do
      it { should validate notifications: { campfire: { disabled: true } } }
      it { should_not validate notifications: { campfire: { disabled: 1 } } }
      it { should_not validate notifications: { campfire: { disabled: :campfire } } }
      it { should_not validate notifications: { campfire: { disabled: [:campfire] } } }
      it { should_not validate notifications: { campfire: { disabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { campfire: { disabled: [{:foo=>'foo'}] } } }
    end

    describe 'rooms' do
      it { should validate notifications: { campfire: { rooms: :campfire } } }
      it { should validate notifications: { campfire: { rooms: [:campfire] } } }
      it { should_not validate notifications: { campfire: { rooms: 1 } } }
      it { should_not validate notifications: { campfire: { rooms: true } } }
      it { should_not validate notifications: { campfire: { rooms: {:foo=>'foo'} } } }
      it { should_not validate notifications: { campfire: { rooms: [{:foo=>'foo'}] } } }
    end

    describe 'template' do
      it { should validate notifications: { campfire: { template: :campfire } } }
      it { should validate notifications: { campfire: { template: [:campfire] } } }
      it { should_not validate notifications: { campfire: { template: 1 } } }
      it { should_not validate notifications: { campfire: { template: true } } }
      it { should_not validate notifications: { campfire: { template: {:foo=>'foo'} } } }
      it { should_not validate notifications: { campfire: { template: [{:foo=>'foo'}] } } }
    end

    describe 'on_start' do
      it { should validate notifications: { campfire: { on_start: 'always' } } }
      it { should_not validate notifications: { campfire: { on_start: 1 } } }
      it { should_not validate notifications: { campfire: { on_start: true } } }
    end

    describe 'on_success' do
      it { should validate notifications: { campfire: { on_success: 'always' } } }
      it { should_not validate notifications: { campfire: { on_success: 1 } } }
      it { should_not validate notifications: { campfire: { on_success: true } } }
    end

    describe 'on_failure' do
      it { should validate notifications: { campfire: { on_failure: 'always' } } }
      it { should_not validate notifications: { campfire: { on_failure: 1 } } }
      it { should_not validate notifications: { campfire: { on_failure: true } } }
    end
  end
end
