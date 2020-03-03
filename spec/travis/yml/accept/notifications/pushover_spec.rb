describe Travis::Yml, 'notifications: pushover' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'given true' do
    yaml %(
      notifications:
        pushover: true
    )
    it { should serialize_to notifications: { pushover: [enabled: true] } }
    it { should_not have_msg }
  end

  describe 'given false' do
    yaml %(
      notifications:
        pushover: false
    )
    it { should serialize_to notifications: { pushover: [enabled: false] } }
    it { should_not have_msg }
  end

  describe 'given disabled: true' do
    yaml %(
      notifications:
        pushover:
          disabled: true
    )
    it { should serialize_to notifications: { pushover: [enabled: false] } }
    it { should_not have_msg }
  end

  describe 'given enabled: false' do
    yaml %(
      notifications:
        pushover:
          enabled: false
    )
    it { should serialize_to notifications: { pushover: [enabled: false] } }
    it { should_not have_msg }
  end

  describe 'given enabled: true' do
    yaml %(
      notifications:
        pushover:
          enabled: true
    )
    it { should serialize_to notifications: { pushover: [enabled: true] } }
    it { should_not have_msg }
  end

  describe 'given disabled: false' do
    yaml %(
      notifications:
        pushover:
          disabled: false
    )
    it { should serialize_to notifications: { pushover: [enabled: true] } }
    it { should_not have_msg }
  end

  describe 'given a str', drop: true do
    yaml %(
      notifications:
        pushover: str
    )
    it { should serialize_to notifications: { pushover: [] } }
    it { should have_msg [:error, :'notifications.pushover', :invalid_type, expected: :map, actual: :str, value: 'str'] }
  end

  describe 'given a secure', drop: true do
    yaml %(
      notifications:
        pushover:
          secure: secure
    )
    it { should serialize_to notifications: { pushover: [] } }
    it { should have_msg [:error, :'notifications.pushover', :invalid_type, expected: :map, actual: :secure, value: { secure: 'secure' }] }
  end

  describe 'given a seq of strs', drop: true do
    yaml %(
      notifications:
        pushover:
          - str
    )
    it { should serialize_to notifications: { pushover: [] } }
    it { should have_msg [:error, :'notifications.pushover', :invalid_type, expected: :map, actual: :str, value: 'str'] }
  end

  describe 'api_key' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          pushover:
            api_key: str
      )
      it { should serialize_to notifications: { pushover: [api_key: ['str']] } }
      it { should have_msg [:alert, :'notifications.pushover.api_key', :secure, type: :str] }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          pushover:
            api_key:
              secure: secure
      )
      it { should serialize_to notifications: { pushover: [api_key: [secure: 'secure']] } }
      it { should_not have_msg }
    end

    describe 'given a hash with an array' do
      yaml %(
        notifications:
          pushover:
            api_key:
            - str
            - other
      )
      it { should serialize_to notifications: { pushover: [api_key: ['str', 'other']] } }
      it { should have_msg [:alert, :'notifications.pushover.api_key', :secure, type: :str] }
    end
  end

  describe 'users' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          pushover:
            users: str
      )
      it { should serialize_to notifications: { pushover: [users: ['str']] } }
      it { should have_msg [:alert, :'notifications.pushover.users', :secure, type: :str] }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          pushover:
            users:
              secure: secure
      )
      it { should serialize_to notifications: { pushover: [users: [secure: 'secure']] } }
      it { should_not have_msg }
    end

    describe 'given a hash with an array' do
      yaml %(
        notifications:
          pushover:
            users:
            - foo
            - bar
      )
      it { should serialize_to notifications: { pushover: [users: ['foo', 'bar']] } }
      it { should have_msg [:alert, :'notifications.pushover.users', :secure, type: :str] }
    end
  end

  describe 'template' do
    describe 'given a str with a known var' do
      yaml %(
        notifications:
          pushover:
            template: "%{repository}"
      )
      it { should serialize_to notifications: { pushover: [template: ['%{repository}']] } }
      it { should_not have_msg }
    end

    describe 'given a str with an unknown var' do
      yaml %(
        notifications:
          pushover:
            template: "%{unknown}"
      )
      it { should serialize_to notifications: { pushover: [template: ['%{unknown}']] } }
      it { should have_msg [:warn, :'notifications.pushover.template', :unknown_var, var: 'unknown'] }
    end

    describe 'given a seq with a known var' do
      yaml %(
        notifications:
          pushover:
            template:
              - "%{repository}"
      )
      it { should serialize_to notifications: { pushover: [template: ['%{repository}']] } }
      it { should_not have_msg }
    end

    describe 'given a seq with an unknown var' do
      yaml %(
        notifications:
          pushover:
            template:
            - "%{unknown}"
      )
      it { should serialize_to notifications: { pushover: [template: ['%{unknown}']] } }
      it { should have_msg [:warn, :'notifications.pushover.template', :unknown_var, var: 'unknown'] }
    end
  end

  %i(on_success on_failure).each do |status|
    describe "inherits shared #{status}" do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              pushover:
                api_key:
                  secure: secure
              #{status}: #{value}
          )
          it { should serialize_to notifications: { pushover: [api_key: [secure: 'secure'], status => value] } }
          it { should_not have_msg }
        end
      end
    end
  end

  describe 'given an unknown key' do
    yaml %(
      notifications:
        pushover:
          unknown: str
    )
    it { should serialize_to notifications: { pushover: [unknown: 'str'] } }
    it { should have_msg [:warn, :'notifications.pushover', :unknown_key, key: 'unknown', value: 'str'] }
  end
end

