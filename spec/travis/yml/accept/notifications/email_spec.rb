describe Travis::Yml, 'notifications: email' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given nil' do
    yaml %(
      notifications:
        email:
    )
    it { should serialize_to empty }
  end

  describe 'given true' do
    yaml %(
      notifications:
        email: true
    )
    it { should serialize_to notifications: { email: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given false' do
    yaml %(
      notifications:
        email: false
    )
    it { should serialize_to notifications: { email: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given enabled: true' do
    yaml %(
      notifications:
        email:
          enabled: true
    )
    it { should serialize_to notifications: { email: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given enabled: false' do
    yaml %(
      notifications:
        email:
          enabled: false
    )
    it { should serialize_to notifications: { email: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given disabled: true' do
    yaml %(
      notifications:
        email:
          disabled: true
    )
    it { should serialize_to notifications: { email: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given disabled: false' do
    yaml %(
      notifications:
        email:
          disabled: false
    )
    it { should serialize_to notifications: { email: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given email: false, disabled: false' do
    yaml %(
      notifications:
        email:
          template: str
    )
    it { should serialize_to notifications: { email: { template: 'str' } } }
    it { should have_msg [:warn, :'notifications.email', :misplaced_key, key: :template, value: 'str'] }
  end

  describe 'emails (alias)' do
    yaml %(
      notifications:
        emails: str
    )
    it { should serialize_to notifications: { email: { recipients: ['str'] } } }
    it { should have_msg [:info, :notifications, :alias, alias: :emails, key: :email] }
  end

  describe 'recipients' do
    describe 'given a string' do
      yaml %(
        notifications:
          email: str

      )
      it { should serialize_to notifications: { email: { recipients: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'given an array' do
      yaml %(
        notifications:
          email:
          - str
      )
      it { should serialize_to notifications: { email: { recipients: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'given an array with a hash' do
      yaml %(
        notifications:
          email:
            - recipients:
              - str
      )
      it { should serialize_to notifications: { email: { recipients: ['str'] } } }
      it { should have_msg [:warn, :'notifications.email', :invalid_seq, value: { recipients: ['str'] }] }
    end

    describe 'given an array with a secure' do
      yaml %(
        notifications:
          email:
            - recipients:
              - secure: secure
      )
      it { should serialize_to notifications: { email: { recipients: [secure: 'secure'] } } }
      it { should have_msg [:warn, :'notifications.email', :invalid_seq, value: { recipients: [secure: 'secure'] }] }
    end

    describe 'given a hash with a string' do
      yaml %(
        notifications:
          email:
            recipients: str
      )
      it { should serialize_to notifications: { email: { recipients: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'given a hash with an array' do
      yaml %(
        notifications:
          email:
            recipients:
              - str
      )
      it { should serialize_to notifications: { email: { recipients: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'does not prefix with :email, given a hash with an unknown key' do
      yaml %(
        notifications:
          unknown: str
      )
      it { should serialize_to notifications: { unknown: 'str' } }
      it { should have_msg [:warn, :notifications, :unknown_key, key: :unknown, value: 'str'] }
    end

    describe 'prefixes with :email, given a hash with the key :recipients, and a string' do
      yaml %(
        notifications:
          recipients: str
      )
      it { should serialize_to notifications: { email: {  recipients: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'prefixes with :email, given a hash with the key :recipients, and an array' do
      yaml %(
        notifications:
          recipients:
            - str
      )
      it { should serialize_to notifications: { email: {  recipients: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'prefixes with :recipients, given a string' do
      yaml %(
        notifications:
          email: str
      )
      it { should serialize_to notifications: { email: {  recipients: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'prefixes with :recipients, given an array' do
      yaml %(
        notifications:
          email:
            - str
      )
      it { should serialize_to notifications: { email: { recipients: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'does not prefix with :recipients, given a hash' do
      yaml %(
        notifications:
          email:
            unknown: str
      )
      it { should serialize_to notifications: { email: { unknown: 'str' } } }
      it { should have_msg [:warn, :'notifications.email', :unknown_key, key: :unknown, value: 'str'] }
    end

    describe 'given a mixed array of hashes and strings' do
      yaml %(
        notifications:
          email:
            - str
            - on_success: change
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :'notifications.email', :invalid_type, expected: :map, actual: :seq, value: ['str', { on_success: 'change' }]] }
    end

    describe 'given a mixed array of hashes and secure' do
      yaml %(
        notifications:
          email:
            - secure: secure
            - on_success: change
      )
      it { should serialize_to empty }
      it { should have_msg [:error, :'notifications.email', :invalid_type, expected: :map, actual: :seq, value: [{ secure: 'secure' }, { on_success: 'change' }]] }
    end

    describe 'prefixes with :email, given a hash with the key :recipients, and a key :email', v2: true, migrate: true do
      yaml %(
        notifications:
          email:
            on_success: always
          recipients:
            - str
      )
      it { should serialize_to notifications: { email: { recipients: ['str'], on_success: 'always' } } }
      it { should_not have_msg }
    end

    describe 'misplaced email, with notifications.email being false', v2: true, migrate: true do
      yaml %(
        notifications:
          email: false
        email: str
      )
      it { should serialize_to notifications: { email: { enabled: true, recipients: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'prefixable key recipients, with notifications.email being present', v2: true, migrate: true do
      yaml %(
        notifications:
          email:
            on_success: change
          recipients:
          - str

      )
      it { should serialize_to notifications: { email: { enabled: true, recipients: ['str'], on_success: 'change' } } }
      it { should have_msg [:warn, :notifications, :migrate, key: :recipients, to: :email, value: ['str']] }
    end
  end

  %i(on_success on_failure).each do |status|
    describe status.inspect do
      %w(always never change).each do |value|
        describe 'accepts %p' % value do
          yaml %(
            notifications:
              email:
                #{status}: #{value}
          )
          it { should serialize_to notifications: { email: { status.to_sym => value } } }
          it { should_not have_msg }
        end
      end
    end
  end
end
