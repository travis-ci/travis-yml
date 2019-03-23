describe Travis::Yml, 'notifications: slack' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given true' do
    yaml %(
      notifications:
        slack: true
    )
    it { should serialize_to notifications: { slack: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given false' do
    yaml %(
      notifications:
        slack: false
    )
    it { should serialize_to notifications: { slack: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given disabled: true' do
    yaml %(
      notifications:
        slack:
          disabled: true
    )
    it { should serialize_to notifications: { slack: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given enabled: false' do
    yaml %(
      notifications:
        slack:
          enabled: false
    )
    it { should serialize_to notifications: { slack: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given enabled: true' do
    yaml %(
      notifications:
        slack:
          enabled: true
    )
    it { should serialize_to notifications: { slack: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given disabled: false' do
    yaml %(
      notifications:
        slack:
          disabled: false
    )
    it { should serialize_to notifications: { slack: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given a str' do
    yaml %(
      notifications:
        slack: str
    )
    it { should serialize_to notifications: { slack: { rooms: ['str'] } } }
    it { should_not have_msg }
  end

  describe 'given a secure' do
    yaml %(
      notifications:
        slack:
          secure: secure
    )
    it { should serialize_to notifications: { slack: { rooms: [secure: 'secure'] } } }
    it { should_not have_msg }
  end

  describe 'given a seq of strs' do
    yaml %(
      notifications:
        slack:
          - foo
          - bar
    )
    it { should serialize_to notifications: { slack: { rooms: ['foo', 'bar'] } } }
    it { should_not have_msg }
  end

  describe 'rooms' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          slack:
            rooms: str
      )
      it { should serialize_to notifications: { slack: { rooms: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          slack:
            rooms:
              secure: secure
      )
      it { should serialize_to notifications: { slack: { rooms: [secure: 'secure'] } } }
      it { should_not have_msg }
    end

    describe 'given a hash with an array' do
      yaml %(
        notifications:
          slack:
            rooms:
            - foo
            - bar
      )
      it { should serialize_to notifications: { slack: { rooms: ['foo', 'bar'] } } }
      it { should_not have_msg }
    end
  end

  describe 'on_pull_requests' do
    describe 'given true' do
      yaml %(
        notifications:
          slack:
            on_pull_requests: true
      )
      it { should serialize_to notifications: { slack: { on_pull_requests: true } } }
      it { should_not have_msg }
    end

    describe 'given yes' do
      yaml %(
        notifications:
          slack:
            on_pull_requests: yes
      )
      it { should serialize_to notifications: { slack: { on_pull_requests: true } } }
      it { should_not have_msg }
    end
  end

  describe 'template' do
    describe 'given a str with a known var' do
      yaml %(
        notifications:
          slack:
            template: "%{repository}"
      )
      it { should serialize_to notifications: { slack: { template: ['%{repository}'] } } }
      it { should_not have_msg }
    end

    describe 'given a str with an unknown var' do
      yaml %(
        notifications:
          slack:
            template: "%{unknown}"
      )
      it { should serialize_to notifications: { slack: { template: ['%{unknown}'] } } }
      it { should have_msg [:warn, :'notifications.slack.template', :unknown_var, var: 'unknown'] }
    end

    describe 'given a seq with a known var' do
      yaml %(
        notifications:
          slack:
            template:
              - "%{repository}"
      )
      it { should serialize_to notifications: { slack: { template: ['%{repository}'] } } }
      it { should_not have_msg }
    end

    describe 'given a seq with an unknown var' do
      yaml %(
        notifications:
          slack:
            template:
            - "%{unknown}"
      )
      it { should serialize_to notifications: { slack: { template: ['%{unknown}'] } } }
      it { should have_msg [:warn, :'notifications.slack.template', :unknown_var, var: 'unknown'] }
    end
  end

  %i(on_success on_failure).each do |status|
    describe status.inspect do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              slack:
                #{status}: #{value}
          )
          it { should serialize_to notifications: { slack: { status => value } } }
          it { should_not have_msg }
        end
      end
    end

    describe "inherits shared #{status}" do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              slack: str
              #{status}: #{value}
          )
          it { should serialize_to notifications: { slack: { rooms: ['str'], status => value } } }
          it { should_not have_msg }
        end
      end
    end
  end

  describe 'given an unknown key' do
    yaml %(
      notifications:
        slack:
          unknown: str
    )
    it { should serialize_to notifications: { slack: { unknown: 'str' } } }
    it { should have_msg [:warn, :'notifications.slack', :unknown_key, key: :unknown, value: 'str'] }
  end
end

