describe Travis::Yml, 'notifications: webhooks' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given true' do
    yaml %(
      notifications:
        webhooks: true
    )
    it { should serialize_to notifications: { webhooks: [enabled: true] } }
    it { should_not have_msg }
  end

  describe 'given false' do
    yaml %(
      notifications:
        webhooks: false
    )
    it { should serialize_to notifications: { webhooks: [enabled: false] } }
    it { should_not have_msg }
  end

  describe 'given disabled: true' do
    yaml %(
      notifications:
        webhooks:
          disabled: true
    )
    it { should serialize_to notifications: { webhooks: [enabled: false] } }
    it { should_not have_msg }
  end

  describe 'given enabled: false' do
    yaml %(
      notifications:
        webhooks:
          enabled: false
    )
    it { should serialize_to notifications: { webhooks: [enabled: false] } }
    it { should_not have_msg }
  end

  describe 'given enabled: true' do
    yaml %(
      notifications:
        webhooks:
          enabled: true
    )
    it { should serialize_to notifications: { webhooks: [enabled: true] } }
    it { should_not have_msg }
  end

  describe 'given disabled: false' do
    yaml %(
      notifications:
        webhooks:
          disabled: false
    )
    it { should serialize_to notifications: { webhooks: [enabled: true] } }
    it { should_not have_msg }
  end

  describe 'given a str' do
    yaml %(
      notifications:
        webhooks: str
    )
    it { should serialize_to notifications: { webhooks: [urls: ['str']] } }
    it { should_not have_msg }
  end

  describe 'given a secure' do
    yaml %(
      notifications:
        webhooks:
          secure: secure
    )
    it { should serialize_to notifications: { webhooks: [urls: [secure: 'secure']] } }
    it { should_not have_msg }
  end

  describe 'given a seq of strs' do
    yaml %(
      notifications:
        webhooks:
          - foo
          - bar
    )
    it { should serialize_to notifications: { webhooks: [{ urls: ['foo'] }, { urls: ['bar'] }] } }
    it { should_not have_msg }
  end

  describe 'urls' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          webhooks:
            urls: str
      )
      it { should serialize_to notifications: { webhooks: [urls: ['str']] } }
      it { should_not have_msg }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          webhooks:
            urls:
              secure: secure
      )
      it { should serialize_to notifications: { webhooks: [urls: [secure: 'secure']] } }
      it { should_not have_msg }
    end

    describe 'given a hash with an array' do
      yaml %(
        notifications:
          webhooks:
            urls:
            - foo
            - bar
      )
      it { should serialize_to notifications: { webhooks: [urls: ['foo', 'bar']] } }
      it { should_not have_msg }
    end
  end

  %i(on_success on_failure).each do |status|
    describe status.inspect do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              webhooks:
                #{status}: #{value}
          )
          it { should serialize_to notifications: { webhooks: [status => value] } }
          it { should_not have_msg }
        end
      end
    end

    describe "inherits shared #{status}" do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              webhooks: str
              #{status}: #{value}
          )
          it { should serialize_to notifications: { webhooks: [urls: ['str'], status => value] } }
          it { should_not have_msg }
        end
      end
    end
  end

  describe 'given an unknown key' do
    yaml %(
      notifications:
        webhooks:
          unknown: str
    )
    it { should serialize_to notifications: { webhooks: [unknown: 'str'] } }
    it { should have_msg [:warn, :'notifications.webhooks', :unknown_key, key: 'unknown', value: 'str'] }
  end

  describe 'given a hash with an unknown template var on a misplaced key', v2: true, migrate: true do
    let(:input) { { notifications: { webhooks: { urls: 'room' }, template: ['%{wat}'] } } }
    it { should serialize_to empty }
    it { should have_msg [:error, :notifications, :misplaced_key, key: 'template', value: ['%{wat}']] }
  end
end

