describe Travis::Yml, 'notifications' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'given nil' do
    yaml %(
      notifications:
    )
    it { should serialize_to empty }
    it { should_not have_msg }
  end

  describe 'given true' do
    yaml %(
      notifications: true
    )
    it { should serialize_to notifications: { email: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given false' do
    yaml %(
      notifications: false
    )
    it { should serialize_to notifications: { email: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'misplaced :recipients' do
    yaml %(
      notifications:
        recipients:
          - str
    )
    it { should serialize_to notifications: { email: { recipients: ['str'] } } }
    it { should_not have_msg }
  end

  describe 'notifications.email' do
    describe 'given nil' do
      yaml %(
        notifications:
          email:
      )
      it { should serialize_to empty }
      it { should_not have_msg }
    end

    describe 'given true' do
      yaml %(
        notifications:
          email: true
      )
      it { should serialize_to notifications: { email: { enabled: true } } }
      it { should_not have_msg }
    end

    describe 'alias emails' do
      yaml %(
        notifications:
          emails: true
      )
      it { should serialize_to notifications: { email: { enabled: true } } }
      it { should have_msg [:info, :notifications, :alias, type: :key, alias: 'emails', obj: 'email'] }
    end

    describe 'typo emaik' do
      yaml %(
        notifications:
          emaik: true
      )
      it { should serialize_to notifications: { email: { enabled: true } } }
      it { should_not have_msg [:warn, :notifications, :find_key, original: 'emailk', key: 'emails'] }
    end

    describe 'given a seq with a map with a str' do
      yaml %(
        notifications:
          - email: me@email.com
      )
      it { should serialize_to notifications: { email: { recipients: ['me@email.com'] } } }
      it { should have_msg [:warn, :notifications, :unexpected_seq, value: { email: 'me@email.com' }] }
    end

    describe 'given a seq with a hash with a bool' do
      yaml %(
        notifications:
          - email: true
      )
      it { should serialize_to notifications: { email: { enabled: true } } }
      it { should have_msg [:warn, :notifications, :unexpected_seq, value: { email: true }] }
    end

    describe 'given a seq with a map with a bool on an alias' do
      yaml %(
        notifications:
          - emails: true
      )
      it { should serialize_to notifications: { email: { enabled: true } } }
      it { should have_msg [:warn, :notifications, :unexpected_seq, value: { email: true }] }
    end

    describe 'given a seq with a map with a bool on a key with a typo' do
      yaml %(
        notifications:
          - emial: true
      )
      it { should serialize_to notifications: { email: { enabled: true } } }
      it { should have_msg [:warn, :notifications, :unexpected_seq, value: { email: true }] }
    end
  end

  describe 'notification (alias)' do
    yaml %(
      notification:
        email:
          recipients:
          - me@email.com
    )
    it { should serialize_to notifications: { email: { recipients: ['me@email.com'] } } }
    it { should have_msg [:warn, :root, :find_key, original: 'notification', key: 'notifications'] }
  end

  describe 'selects change for :change' do
    yaml %(
      notification:
        email: true
        on_success: ":change"
    )
    it { should serialize_to notifications: { email: { enabled: true, on_success: 'change' } } }
    it { should have_msg [:warn, :'notifications.on_success', :find_value, original: ':change', value: 'change'] }
  end

  describe 'on_failure given true' do
    yaml %(
      notifications:
        email: true
        on_failure: true
    )
    it { should serialize_to notifications: { email: { enabled: true, on_failure: 'always' } } }
    it { should have_msg [:info, :'notifications.on_failure', :alias, type: :value, alias: 'true', obj: 'always'] }
  end

  describe 'given on-sucsess (typo, dasherized)' do
    yaml %(
      notifications:
        email:
          on-sucsess: :change
    )
    it { should serialize_to notifications: { email: { on_success: 'change' } } }
    it { should have_msg [:warn, :'notifications.email', :find_key, original: 'on-sucsess', key: 'on_success'] }
  end

  describe 'given a seq with a map' do
    yaml %(
      notifications:
        slack:
        - on_success: always
    )
    it { should serialize_to notifications: { slack: { on_success: 'always' } } }
    it { should have_msg [:warn, :'notifications.slack', :unexpected_seq, value: { on_success: 'always' }] }
  end

  describe 'given a seq with two map with the same key' do
    yaml %(
      notifications:
        - slack: foo
        - slack: bar
    )
    it { should serialize_to notifications: { slack: { rooms: ['foo'] } } }
    it { should have_msg [:warn, :notifications, :unexpected_seq, value: { slack: 'foo' }] }
  end

  describe 'given a seq with email: true, and irc: channel' do
    yaml %(
      notifications:
        email: true
        irc: channel
    )
    it { should serialize_to notifications: { email: { enabled: true }, irc: { channels: ['channel'] } } }
  end
end
