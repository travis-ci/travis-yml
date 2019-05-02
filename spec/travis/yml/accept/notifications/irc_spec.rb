describe Travis::Yml, 'notifications: irc' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given true' do
    yaml %(
      notifications:
        irc: true
    )
    it { should serialize_to notifications: { irc: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given false' do
    yaml %(
      notifications:
        irc: false
    )
    it { should serialize_to notifications: { irc: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given disabled: true' do
    yaml %(
      notifications:
        irc:
          disabled: true
    )
    it { should serialize_to notifications: { irc: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given enabled: false' do
    yaml %(
      notifications:
        irc:
          enabled: false
    )
    it { should serialize_to notifications: { irc: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given enabled: true' do
    yaml %(
      notifications:
        irc:
          enabled: true
    )
    it { should serialize_to notifications: { irc: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given disabled: false' do
    yaml %(
      notifications:
        irc:
          disabled: false
    )
    it { should serialize_to notifications: { irc: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given a str' do
    yaml %(
      notifications:
        irc: str
    )
    it { should serialize_to notifications: { irc: { channels: ['str'] } } }
    it { should_not have_msg }
  end

  describe 'given a secure' do
    yaml %(
      notifications:
        irc:
          secure: secure
    )
    it { should serialize_to notifications: { irc: { channels: [secure: 'secure'] } } }
    it { should_not have_msg }
  end

  describe 'given a seq of strs' do
    yaml %(
      notifications:
        irc:
          - foo
          - bar
    )
    it { should serialize_to notifications: { irc: { channels: ['foo', 'bar'] } } }
    it { should_not have_msg }
  end

  describe 'channels' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          irc:
            channels: str
      )
      it { should serialize_to notifications: { irc: { channels: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          irc:
            channels:
              secure: secure
      )
      it { should serialize_to notifications: { irc: { channels: [secure: 'secure'] } } }
      it { should_not have_msg }
    end

    describe 'given a hash with an array' do
      yaml %(
        notifications:
          irc:
            channels:
            - foo
            - bar
      )
      it { should serialize_to notifications: { irc: { channels: ['foo', 'bar'] } } }
      it { should_not have_msg }
    end
  end

  describe 'channel_key' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          irc:
            channel_key: str
      )
      it { should serialize_to notifications: { irc: { channel_key: 'str' } } }
      it { should_not have_msg }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          irc:
            channel_key:
              secure: secure
      )
      it { should serialize_to notifications: { irc: { channel_key: { secure: 'secure' } } } }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          irc:
            password: str
      )
      it { should serialize_to notifications: { irc: { password: 'str' } } }
      it { should_not have_msg }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          irc:
            password:
              secure: secure
      )
      it { should serialize_to notifications: { irc: { password: { secure: 'secure' } } } }
      it { should_not have_msg }
    end
  end

  describe 'nickserv_password' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          irc:
            nickserv_password: str
      )
      it { should serialize_to notifications: { irc: { nickserv_password: 'str' } } }
      it { should_not have_msg }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          irc:
            nickserv_password:
              secure: secure
      )
      it { should serialize_to notifications: { irc: { nickserv_password: { secure: 'secure' } } } }
      it { should_not have_msg }
    end
  end

  describe 'nick' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          irc:
            nick: str
      )
      it { should serialize_to notifications: { irc: { nick: 'str' } } }
      it { should_not have_msg }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          irc:
            nick:
              secure: secure
      )
      it { should serialize_to notifications: { irc: { nick: { secure: 'secure' } } } }
      it { should_not have_msg }
    end
  end

  describe 'use_notice' do
    describe 'given true' do
      yaml %(
        notifications:
          irc:
            use_notice: true
      )
      it { should serialize_to notifications: { irc: { use_notice: true } } }
      it { should_not have_msg }
    end

    describe 'given yes' do
      yaml %(
        notifications:
          irc:
            use_notice: yes
      )
      it { should serialize_to notifications: { irc: { use_notice: true } } }
      it { should_not have_msg }
    end
  end

  describe 'skip_join' do
    describe 'given true' do
      yaml %(
        notifications:
          irc:
            skip_join: true
      )
      it { should serialize_to notifications: { irc: { skip_join: true } } }
      it { should_not have_msg }
    end

    describe 'given yes' do
      yaml %(
        notifications:
          irc:
            skip_join: yes
      )
      it { should serialize_to notifications: { irc: { skip_join: true } } }
      it { should_not have_msg }
    end
  end

  describe 'template' do
    describe 'given a str with a known var' do
      yaml %(
        notifications:
          irc:
            template: "%{repository}"
      )
      it { should serialize_to notifications: { irc: { template: ['%{repository}'] } } }
      it { should_not have_msg }
    end

    describe 'given a str with an unknown var' do
      yaml %(
        notifications:
          irc:
            template: "%{unknown}"
      )
      it { should serialize_to notifications: { irc: { template: ['%{unknown}'] } } }
      it { should have_msg [:warn, :'notifications.irc.template', :unknown_var, var: 'unknown'] }
    end

    describe 'given a seq with a known var' do
      yaml %(
        notifications:
          irc:
            template:
              - "%{repository}"
      )
      it { should serialize_to notifications: { irc: { template: ['%{repository}'] } } }
      it { should_not have_msg }
    end

    describe 'given a seq with an unknown var' do
      yaml %(
        notifications:
          irc:
            template:
            - "%{unknown}"
      )
      it { should serialize_to notifications: { irc: { template: ['%{unknown}'] } } }
      it { should have_msg [:warn, :'notifications.irc.template', :unknown_var, var: 'unknown'] }
    end
  end

  %i(on_success on_failure).each do |status|
    describe status.inspect do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              irc:
                #{status}: #{value}
          )
          it { should serialize_to notifications: { irc: { status => value } } }
          it { should_not have_msg }
        end
      end
    end

    describe "inherits shared #{status}" do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              irc: str
              #{status}: #{value}
          )
          it { should serialize_to notifications: { irc: { channels: ['str'], status => value } } }
          it { should_not have_msg }
        end
      end
    end
  end

  describe 'given an unknown key' do
    yaml %(
      notifications:
        irc:
          unknown: str
    )
    it { should serialize_to notifications: { irc: { unknown: 'str' } } }
    it { should have_msg [:warn, :'notifications.irc', :unknown_key, key: 'unknown', value: 'str'] }
  end

  describe 'given a hash with an unknown template var on a misplaced key' do
    yaml %(
      notifications:
        irc:
          channels:
          - room
        template: str
    )
    it { should serialize_to notifications: { irc: { channels: ['room'] }, template: 'str' } }
    it { should have_msg [:warn, :notifications, :unknown_key, key: 'template', value: 'str'] }
  end
end

