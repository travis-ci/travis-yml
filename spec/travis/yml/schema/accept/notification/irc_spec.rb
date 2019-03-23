describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:irc]) }

  describe 'irc' do
    describe 'enabled' do
      it { should validate notifications: { irc: { enabled: true } } }
      it { should_not validate notifications: { irc: { enabled: 1 } } }
      it { should_not validate notifications: { irc: { enabled: :irc } } }
      it { should_not validate notifications: { irc: { enabled: [:irc] } } }
      it { should_not validate notifications: { irc: { enabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { irc: { enabled: [{:foo=>'foo'}] } } }
    end

    describe 'disabled' do
      it { should validate notifications: { irc: { disabled: true } } }
      it { should_not validate notifications: { irc: { disabled: 1 } } }
      it { should_not validate notifications: { irc: { disabled: :irc } } }
      it { should_not validate notifications: { irc: { disabled: [:irc] } } }
      it { should_not validate notifications: { irc: { disabled: {:foo=>'foo'} } } }
      it { should_not validate notifications: { irc: { disabled: [{:foo=>'foo'}] } } }
    end

    describe 'channels' do
      it { should validate notifications: { irc: { channels: :irc } } }
      it { should validate notifications: { irc: { channels: [:irc] } } }
      it { should_not validate notifications: { irc: { channels: 1 } } }
      it { should_not validate notifications: { irc: { channels: true } } }
      it { should_not validate notifications: { irc: { channels: {:foo=>'foo'} } } }
      it { should_not validate notifications: { irc: { channels: [{:foo=>'foo'}] } } }
    end

    describe 'channel_key' do
      it { should validate notifications: { irc: { channel_key: :irc } } }
      it { should_not validate notifications: { irc: { channel_key: 1 } } }
      it { should_not validate notifications: { irc: { channel_key: true } } }
      it { should_not validate notifications: { irc: { channel_key: [:irc] } } }
      it { should_not validate notifications: { irc: { channel_key: {:foo=>'foo'} } } }
      it { should_not validate notifications: { irc: { channel_key: [{:foo=>'foo'}] } } }
    end

    describe 'password' do
      it { should validate notifications: { irc: { password: :irc } } }
      it { should_not validate notifications: { irc: { password: 1 } } }
      it { should_not validate notifications: { irc: { password: true } } }
      it { should_not validate notifications: { irc: { password: [:irc] } } }
      it { should_not validate notifications: { irc: { password: {:foo=>'foo'} } } }
      it { should_not validate notifications: { irc: { password: [{:foo=>'foo'}] } } }
    end

    describe 'nickserv_password' do
      it { should validate notifications: { irc: { nickserv_password: :irc } } }
      it { should_not validate notifications: { irc: { nickserv_password: 1 } } }
      it { should_not validate notifications: { irc: { nickserv_password: true } } }
      it { should_not validate notifications: { irc: { nickserv_password: [:irc] } } }
      it { should_not validate notifications: { irc: { nickserv_password: {:foo=>'foo'} } } }
      it { should_not validate notifications: { irc: { nickserv_password: [{:foo=>'foo'}] } } }
    end

    describe 'nick' do
      it { should validate notifications: { irc: { nick: :irc } } }
      it { should_not validate notifications: { irc: { nick: 1 } } }
      it { should_not validate notifications: { irc: { nick: true } } }
      it { should_not validate notifications: { irc: { nick: [:irc] } } }
      it { should_not validate notifications: { irc: { nick: {:foo=>'foo'} } } }
      it { should_not validate notifications: { irc: { nick: [{:foo=>'foo'}] } } }
    end

    describe 'use_notice' do
      it { should validate notifications: { irc: { use_notice: true } } }
      it { should_not validate notifications: { irc: { use_notice: 1 } } }
      it { should_not validate notifications: { irc: { use_notice: :irc } } }
      it { should_not validate notifications: { irc: { use_notice: [:irc] } } }
      it { should_not validate notifications: { irc: { use_notice: {:foo=>'foo'} } } }
      it { should_not validate notifications: { irc: { use_notice: [{:foo=>'foo'}] } } }
    end

    describe 'skip_join' do
      it { should validate notifications: { irc: { skip_join: true } } }
      it { should_not validate notifications: { irc: { skip_join: 1 } } }
      it { should_not validate notifications: { irc: { skip_join: :irc } } }
      it { should_not validate notifications: { irc: { skip_join: [:irc] } } }
      it { should_not validate notifications: { irc: { skip_join: {:foo=>'foo'} } } }
      it { should_not validate notifications: { irc: { skip_join: [{:foo=>'foo'}] } } }
    end

    describe 'template' do
      it { should validate notifications: { irc: { template: :irc } } }
      it { should validate notifications: { irc: { template: [:irc] } } }
      it { should_not validate notifications: { irc: { template: 1 } } }
      it { should_not validate notifications: { irc: { template: true } } }
      it { should_not validate notifications: { irc: { template: {:foo=>'foo'} } } }
      it { should_not validate notifications: { irc: { template: [{:foo=>'foo'}] } } }
    end

    describe 'on_start' do
      it { should validate notifications: { irc: { on_start: 'always' } } }
      it { should_not validate notifications: { irc: { on_start: 1 } } }
      it { should_not validate notifications: { irc: { on_start: true } } }
    end

    describe 'on_success' do
      it { should validate notifications: { irc: { on_success: 'always' } } }
      it { should_not validate notifications: { irc: { on_success: 1 } } }
      it { should_not validate notifications: { irc: { on_success: true } } }
    end

    describe 'on_failure' do
      it { should validate notifications: { irc: { on_failure: 'always' } } }
      it { should_not validate notifications: { irc: { on_failure: 1 } } }
      it { should_not validate notifications: { irc: { on_failure: true } } }
    end
  end
end
