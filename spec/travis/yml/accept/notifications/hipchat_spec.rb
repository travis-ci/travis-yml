describe Travis::Yml do
  accept 'notifications: hipchat' do
    describe 'given true' do
      yaml %(
        notifications:
          hipchat: true
      )
      it { should serialize_to notifications: { hipchat: [enabled: true] } }
      it { should_not have_msg }
    end

    describe 'given false' do
      yaml %(
        notifications:
          hipchat: false
      )
      it { should serialize_to notifications: { hipchat: [enabled: false] } }
      it { should_not have_msg }
    end

    describe 'given disabled: true' do
      yaml %(
        notifications:
          hipchat:
            disabled: true
      )
      it { should serialize_to notifications: { hipchat: [enabled: false] } }
      it { should_not have_msg }
    end

    describe 'given enabled: false' do
      yaml %(
        notifications:
          hipchat:
            enabled: false
      )
      it { should serialize_to notifications: { hipchat: [enabled: false] } }
      it { should_not have_msg }
    end

    describe 'given enabled: true' do
      yaml %(
        notifications:
          hipchat:
            enabled: true
      )
      it { should serialize_to notifications: { hipchat: [enabled: true] } }
      it { should_not have_msg }
    end

    describe 'given disabled: false' do
      yaml %(
        notifications:
          hipchat:
            disabled: false
      )
      it { should serialize_to notifications: { hipchat: [enabled: true] } }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        notifications:
          hipchat: str
      )
      it { should serialize_to notifications: { hipchat: [rooms: ['str']] } }
      it { should have_msg [:alert, :'notifications.hipchat.rooms', :secure, type: :str] }
    end

    describe 'given a secure' do
      yaml %(
        notifications:
          hipchat:
            secure: #{secure}
      )
      it { should serialize_to notifications: { hipchat: [rooms: [secure: secure]] } }
      it { should_not have_msg }
    end

    describe 'given a seq of strs' do
      yaml %(
        notifications:
          hipchat:
            - foo
            - bar
      )
      it { should serialize_to notifications: { hipchat: [{ rooms: ['foo'] }, { rooms: ['bar'] }] } }
        it { should have_msg [:alert, :'notifications.hipchat.rooms', :secure, type: :str] }
    end

    describe 'rooms' do
      describe 'given a hash with a string' do
        yaml %(
          notifications:
            hipchat:
              rooms: str
        )
        it { should serialize_to notifications: { hipchat: [rooms: ['str']] } }
        it { should have_msg [:alert, :'notifications.hipchat.rooms', :secure, type: :str] }
      end

      describe 'given a hash with a secure' do
        yaml %(
          notifications:
            hipchat:
              rooms:
                secure: #{secure}
        )
        it { should serialize_to notifications: { hipchat: [rooms: [secure: secure]] } }
        it { should_not have_msg }
      end

      describe 'given a hash with an array' do
        yaml %(
          notifications:
            hipchat:
              rooms:
              - foo
              - bar
        )
        it { should serialize_to notifications: { hipchat: [rooms: ['foo', 'bar']] } }
        it { should have_msg [:alert, :'notifications.hipchat.rooms', :secure, type: :str] }
      end
    end

    describe 'template' do
      describe 'given a str with a known var' do
        yaml %(
          notifications:
            hipchat:
              template: "%{repository}"
        )
        it { should serialize_to notifications: { hipchat: [template: ['%{repository}']] } }
        it { should_not have_msg }
      end

      describe 'given a str with an unknown var' do
        yaml %(
          notifications:
            hipchat:
              template: "%{unknown}"
        )
        it { should serialize_to notifications: { hipchat: [template: ['%{unknown}']] } }
        it { should have_msg [:warn, :'notifications.hipchat.template', :unknown_var, var: 'unknown'] }
      end

      describe 'given a seq with a known var' do
        yaml %(
          notifications:
            hipchat:
              template:
                - "%{repository}"
        )
        it { should serialize_to notifications: { hipchat: [template: ['%{repository}']] } }
        it { should_not have_msg }
      end

      describe 'given a seq with an unknown var' do
        yaml %(
          notifications:
            hipchat:
              template:
              - "%{unknown}"
        )
        it { should serialize_to notifications: { hipchat: [template: ['%{unknown}']] } }
        it { should have_msg [:warn, :'notifications.hipchat.template', :unknown_var, var: 'unknown'] }
      end
    end

    %i(on_success on_failure).each do |status|
      describe status.inspect do
        %w(always never change).each do |value|
          describe 'given %p' % value do
            yaml %(
              notifications:
                hipchat:
                  #{status}: #{value}
            )
            it { should serialize_to notifications: { hipchat: [status => value] } }
            it { should_not have_msg }
          end
        end
      end

      describe "inherits shared #{status}" do
        %w(always never change).each do |value|
          describe 'given %p' % value do
            yaml %(
              notifications:
                hipchat: str
                #{status}: #{value}
            )
            it { should serialize_to notifications: { hipchat: [rooms: ['str'], status => value] } }
            it { should have_msg [:alert, :'notifications.hipchat.rooms', :secure, type: :str] }
          end
        end
      end
    end

    describe 'given an unknown key' do
      yaml %(
        notifications:
          hipchat:
            unknown: str
      )
      it { should serialize_to notifications: { hipchat: [unknown: 'str'] } }
      it { should have_msg [:warn, :'notifications.hipchat', :unknown_key, key: 'unknown', value: 'str'] }
    end
  end
end
