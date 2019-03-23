describe Travis::Yaml, 'notifications: campfire' do
  let(:campfire)      { notifications[:campfire] }
  let(:notifications) { subject.serialize[:notifications] }

  subject { described_class.apply(input) }

  describe 'disabled via false' do
    let(:input) { { notifications: { campfire: false } } }
    it { expect(campfire).to eq(enabled: false) }
  end

  describe 'disabled via disabled: true' do
    let(:input) { { notifications: { campfire: { disabled: true } } } }
    it { expect(campfire).to eq(enabled: false) }
  end

  describe 'disabled via enabled: false' do
    let(:input) { { notifications: { campfire: { enabled: false } } } }
    it { expect(campfire).to eq(enabled: false) }
  end

  describe 'enabled by default' do
    let(:input) { { notifications: { campfire: { rooms: 'room' } } } }
    it { expect(campfire).to include(enabled: true) }
  end

  describe 'enabled via true' do
    let(:input) { { notifications: { campfire: true } } }
    it { expect(campfire).to eq(enabled: true) }
  end

  describe 'enabled via enabled: true' do
    let(:input) { { notifications: { campfire: { enabled: true } } } }
    it { expect(campfire).to eq(enabled: true) }
  end

  describe 'enabled via disabled: false' do
    let(:input) { { notifications: { campfire: { disabled: false } } } }
    it { expect(campfire).to eq(enabled: true) }
  end

  describe 'given a string' do
    let(:input) { { notifications: { campfire: 'room' } } }
    it { expect(campfire).to include(rooms: ['room']) }
  end

  describe 'given a secure' do
    let(:input) { { notifications: { campfire: { secure: 'room' } } } }
    it { expect(campfire).to include(rooms: [secure: 'room']) }
  end

  describe 'given an array' do
    let(:input) { { notifications: { campfire: ['room'] } } }
    it { expect(campfire).to include(rooms: ['room']) }
  end

  describe 'given a hash with a string' do
    let(:input) { { notifications: { campfire: { rooms: 'room' } } } }
    it { expect(campfire).to include(rooms: ['room']) }
  end

  describe 'given a hash with a secure' do
    let(:input) { { notifications: { campfire: { rooms: { secure: 'room' } } } } }
    it { expect(campfire).to include(rooms: [secure: 'room']) }
  end

  describe 'given a hash with an array' do
    let(:input) { { notifications: { campfire: { rooms: ['room'] } } } }
    it { expect(campfire).to include(rooms: ['room']) }
  end

  describe 'unknown keys' do
    let(:input) { { notifications: { campfire: { foo: 'foo' } } } }
    it { expect(campfire).to eq enabled: true }
    it { expect(msgs).to include [:error, :'notifications.campfire', :unknown_key, key: :foo, value: 'foo'] }
  end

  Travis::Yaml::Spec::Def::Notifications::Template::VARS[0..1].each do |var|
    describe "given a hash with template var #{var}" do
      let(:input) { { notifications: { campfire: { template: ["%{#{var}}"] } } } }
      it { expect(campfire).to include(template: ["%{#{var}}"]) }
      it { expect(msgs).to be_empty }
    end
  end

  describe 'given a hash with an unknown template var' do
    let(:input) { { notifications: { campfire: { rooms: 'room', template: ['%{wat}'] } } } }
    it { expect(campfire[:template]).to be_nil }
    it { expect(msgs).to include [:error, :'notifications.campfire.template', :unknown_var, var: 'wat'] }
  end

  describe 'given a hash with an unknown template var on a misplaced key' do
    let(:input) { { notifications: { campfire: { rooms: 'room' }, template: ['%{wat}'] } } }
    it { expect(campfire[:template]).to be_nil }
    it { expect(msgs).to include [:error, :notifications, :misplaced_key, key: :template, value: ['%{wat}']] }
  end

  describe 'given a hash with an unknown template var on a misplaced key and the wrong notification type' do
    let(:input) { { notifications: { email: true, template: ['%{wat}'] } } }
    it { expect(subject.serialize[:notifications]).to eq email: { enabled: true } }
    it { expect(msgs).to include [:error, :notifications, :misplaced_key, key: :template, value: ['%{wat}']] }
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:input) { { notifications: { campfire: { callback.to_sym => value } } } }
            it { expect(campfire[callback.to_sym]).to eq value }
          end
        end
      end

      describe "inherits shared #{callback}" do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:input) { { notifications: { campfire: { rooms: 'room' }, callback.to_sym => value } } }
            it { expect(campfire[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end
end
