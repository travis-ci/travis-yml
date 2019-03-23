describe Travis::Yml, 'notifications: flowdock' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given true' do
    yaml %(
      notifications:
        flowdock: true
    )
    it { should serialize_to notifications: { flowdock: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given false' do
    yaml %(
      notifications:
        flowdock: false
    )
    it { should serialize_to notifications: { flowdock: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given disabled: true' do
    yaml %(
      notifications:
        flowdock:
          disabled: true
    )
    it { should serialize_to notifications: { flowdock: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given enabled: false' do
    yaml %(
      notifications:
        flowdock:
          enabled: false
    )
    it { should serialize_to notifications: { flowdock: { enabled: false } } }
    it { should_not have_msg }
  end

  describe 'given enabled: true' do
    yaml %(
      notifications:
        flowdock:
          enabled: true
    )
    it { should serialize_to notifications: { flowdock: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given disabled: false' do
    yaml %(
      notifications:
        flowdock:
          disabled: false
    )
    it { should serialize_to notifications: { flowdock: { enabled: true } } }
    it { should_not have_msg }
  end

  describe 'given a str' do
    yaml %(
      notifications:
        flowdock: str
    )
    it { should serialize_to notifications: { flowdock: { api_token: 'str' } } }
    it { should_not have_msg }
  end

  describe 'given a secure' do
    yaml %(
      notifications:
        flowdock:
          secure: secure
    )
    it { should serialize_to notifications: { flowdock: { api_token: { secure: 'secure' } } } }
    it { should_not have_msg }
  end

  describe 'given a seq of strs' do
    yaml %(
      notifications:
        flowdock:
          - str
          - other
    )
    it { should serialize_to notifications: { flowdock: { api_token: 'str' } } }
    it { should have_msg [:warn, :'notifications.flowdock.api_token', :invalid_seq, value: 'str'] }
  end

  describe 'api_token' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          flowdock:
            api_token: str
      )
      it { should serialize_to notifications: { flowdock: { api_token: 'str' } } }
      it { should_not have_msg }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          flowdock:
            api_token:
              secure: secure
      )
      it { should serialize_to notifications: { flowdock: { api_token: { secure: 'secure' } } } }
      it { should_not have_msg }
    end

    describe 'given a hash with an array' do
      yaml %(
        notifications:
          flowdock:
            api_token:
            - str
            - other
      )
      it { should serialize_to notifications: { flowdock: { api_token: 'str' } } }
      it { should have_msg [:warn, :'notifications.flowdock.api_token', :invalid_seq, value: 'str'] }
    end
  end

  describe 'template' do
    describe 'given a str with a known var' do
      yaml %(
        notifications:
          flowdock:
            template: "%{repository}"
      )
      it { should serialize_to notifications: { flowdock: { template: ['%{repository}'] } } }
      it { should_not have_msg }
    end

    describe 'given a str with an unknown var' do
      yaml %(
        notifications:
          flowdock:
            template: "%{unknown}"
      )
      it { should serialize_to notifications: { flowdock: { template: ['%{unknown}'] } } }
      it { should have_msg [:warn, :'notifications.flowdock.template', :unknown_var, var: 'unknown'] }
    end

    describe 'given a seq with a known var' do
      yaml %(
        notifications:
          flowdock:
            template:
              - "%{repository}"
      )
      it { should serialize_to notifications: { flowdock: { template: ['%{repository}'] } } }
      it { should_not have_msg }
    end

    describe 'given a seq with an unknown var' do
      yaml %(
        notifications:
          flowdock:
            template:
            - "%{unknown}"
      )
      it { should serialize_to notifications: { flowdock: { template: ['%{unknown}'] } } }
      it { should have_msg [:warn, :'notifications.flowdock.template', :unknown_var, var: 'unknown'] }
    end
  end

  %i(on_success on_failure).each do |status|
    describe status.inspect do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              flowdock:
                #{status}: #{value}
          )
          it { should serialize_to notifications: { flowdock: { status => value } } }
          it { should_not have_msg }
        end
      end
    end

    describe "inherits shared #{status}" do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              flowdock: str
              #{status}: #{value}
          )
          it { should serialize_to notifications: { flowdock: { api_token: 'str', status => value } } }
          it { should_not have_msg }
        end
      end
    end
  end

  describe 'given an unknown key' do
    yaml %(
      notifications:
        flowdock:
          unknown: str
    )
    it { should serialize_to notifications: { flowdock: { unknown: 'str' } } }
    it { should have_msg [:warn, :'notifications.flowdock', :unknown_key, key: :unknown, value: 'str'] }
  end
end
