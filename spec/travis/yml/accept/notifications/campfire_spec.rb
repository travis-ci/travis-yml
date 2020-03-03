describe Travis::Yml, 'notifications: campfire' do
  subject { described_class.load(yaml) }

  describe 'given true' do
    yaml %(
      notifications:
        campfire: true
    )
    it { should serialize_to notifications: { campfire: [enabled: true] } }
    it { should_not have_msg }
  end

  describe 'given false' do
    yaml %(
      notifications:
        campfire: false
    )
    it { should serialize_to notifications: { campfire: [enabled: false] } }
    it { should_not have_msg }
  end

  describe 'given disabled: true' do
    yaml %(
      notifications:
        campfire:
          disabled: true
    )
    it { should serialize_to notifications: { campfire: [enabled: false] } }
    it { should_not have_msg }
  end

  describe 'given enabled: false' do
    yaml %(
      notifications:
        campfire:
          enabled: false
    )
    it { should serialize_to notifications: { campfire: [enabled: false] } }
    it { should_not have_msg }
  end

  describe 'given enabled: true' do
    yaml %(
      notifications:
        campfire:
          enabled: true
    )
    it { should serialize_to notifications: { campfire: [enabled: true] } }
    it { should_not have_msg }
  end

  describe 'given disabled: false' do
    yaml %(
      notifications:
        campfire:
          disabled: false
    )
    it { should serialize_to notifications: { campfire: [enabled: true] } }
    it { should_not have_msg }
  end

  describe 'given a str' do
    yaml %(
      notifications:
        campfire: str
    )
    it { should serialize_to notifications: { campfire: [rooms: ['str']] } }
    it { should_not have_msg }
  end

  describe 'given a secure' do
    yaml %(
      notifications:
        campfire:
          secure: secure
    )
    it { should serialize_to notifications: { campfire: [rooms: [secure: 'secure']] } }
    it { should_not have_msg }
  end

  describe 'given a seq of strs' do
    yaml %(
      notifications:
        campfire:
          - foo
          - bar
    )
    it { should serialize_to notifications: { campfire: [{ rooms: ['foo'] }, { rooms: ['bar'] }] } }
    it { should_not have_msg }
  end

  describe 'rooms' do
    describe 'given a hash with a string' do
      yaml %(
        notifications:
          campfire:
            rooms: str
      )
      it { should serialize_to notifications: { campfire: [rooms: ['str']] } }
      it { should_not have_msg }
    end

    describe 'given a hash with a secure' do
      yaml %(
        notifications:
          campfire:
            rooms:
              secure: secure
      )
      it { should serialize_to notifications: { campfire: [rooms: [secure: 'secure']] } }
      it { should_not have_msg }
    end

    describe 'given a hash with an array' do
      yaml %(
        notifications:
          campfire:
            rooms:
            - foo
            - bar
      )
      it { should serialize_to notifications: { campfire: [rooms: ['foo', 'bar']] } }
      it { should_not have_msg }
    end
  end

  describe 'template' do
    describe 'given a str with a known var' do
      yaml %(
        notifications:
          campfire:
            template: "%{repository}"
      )
      it { should serialize_to notifications: { campfire: [template: ['%{repository}']] } }
      it { should_not have_msg }
    end

    describe 'given a str with an unknown var' do
      yaml %(
        notifications:
          campfire:
            template: "%{unknown}"
      )
      it { should serialize_to notifications: { campfire: [template: ['%{unknown}']] } }
      it { should have_msg [:warn, :'notifications.campfire.template', :unknown_var, var: 'unknown'] }
    end

    describe 'given a seq with a known var' do
      yaml %(
        notifications:
          campfire:
            template:
              - "%{repository}"
      )
      it { should serialize_to notifications: { campfire: [template: ['%{repository}']] } }
      it { should_not have_msg }
    end

    describe 'given a seq with an unknown var' do
      yaml %(
        notifications:
          campfire:
            template:
            - "%{unknown}"
      )
      it { should serialize_to notifications: { campfire: [template: ['%{unknown}']] } }
      it { should have_msg [:warn, :'notifications.campfire.template', :unknown_var, var: 'unknown'] }
    end
  end

  %i(on_success on_failure).each do |status|
    describe status.inspect do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              campfire:
                #{status}: #{value}
          )
          it { should serialize_to notifications: { campfire: [status => value] } }
          it { should_not have_msg }
        end
      end
    end

    describe "inherits shared #{status}" do
      %w(always never change).each do |value|
        describe 'given %p' % value do
          yaml %(
            notifications:
              campfire: str
              #{status}: #{value}
          )
          it { should serialize_to notifications: { campfire: [rooms: ['str'], status => value] } }
          it { should_not have_msg }
        end
      end
    end
  end

  describe 'given an unknown key' do
    yaml %(
      notifications:
        campfire:
          unknown: str
    )
    it { should serialize_to notifications: { campfire: [unknown: 'str'] } }
    it { should have_msg [:warn, :'notifications.campfire', :unknown_key, key: 'unknown', value: 'str'] }
  end

  describe 'given a hash with an unknown template var on a misplaced key', v2: true, migrate: true do
    let(:input) { { notifications: { campfire: { rooms: 'room' }, template: ['%{wat}'] } } }
    it { should serialize_to empty }
    it { should have_msg [:error, :notifications, :misplaced_key, key: 'template', value: ['%{wat}']] }
  end
end
