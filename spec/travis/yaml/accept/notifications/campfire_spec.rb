describe Travis::Yaml, 'notifications: campfire' do
  let(:msgs)     { subject.msgs }
  let(:campfire) { subject.to_h[:notifications][:campfire] }

  subject { described_class.apply(config.merge(language: 'ruby', sudo: false)) }

  describe 'given a string' do
    let(:config) { { notifications: { campfire: 'room' } } }
    it { expect(campfire).to include(rooms: ['room']) }
  end

  describe 'given an array' do
    let(:config) { { notifications: { campfire: ['room'] } } }
    it { expect(campfire).to include(rooms: ['room']) }
  end

  describe 'given a hash with a string' do
    let(:config) { { notifications: { campfire: { rooms: 'room' } } } }
    it { expect(campfire).to include(rooms: ['room']) }
  end

  describe 'given a hash with an array' do
    let(:config) { { notifications: { campfire: { rooms: ['room'] } } } }
    it { expect(campfire).to include(rooms: ['room']) }
  end

  Travis::Yaml::Spec::Def::Notifications::Template::VARS[0..1].each do |var|
    describe "given a hash with template var #{var}" do
      let(:config) { { notifications: { campfire: { template: ["%{#{var}}"] } } } }
      it { expect(campfire).to include(template: ["%{#{var}}"]) }
      it { expect(msgs).to be_empty }
    end
  end

  describe 'given a hash with an unknown template var' do
    let(:config) { { notifications: { campfire: { rooms: 'room', template: ['%{wat}'] } } } }
    it { expect(campfire[:template]).to be_nil }
    it { expect(msgs).to include [:error, :'notifications.campfire', :unknown_var, 'unknown template variable "wat"'] }
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { campfire: { callback.to_sym => value } } } }
            it { expect(campfire[callback.to_sym]).to eq value }
          end
        end
      end

      describe "inherits shared #{callback}" do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { campfire: { rooms: 'room' }, callback.to_sym => value } } }
            it { expect(campfire[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end
end
