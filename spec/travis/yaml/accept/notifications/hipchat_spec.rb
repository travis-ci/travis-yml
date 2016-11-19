describe Travis::Yaml, 'notifications: hipchat' do
  let(:msgs)    { subject.msgs }
  let(:hipchat) { subject.to_h[:notifications][:hipchat] }

  subject { described_class.apply(config) }

  describe 'given a string' do
    let(:config) { { notifications: { hipchat: 'room' } } }
    it { expect(hipchat).to include(rooms: ['room']) }
  end

  describe 'given a hash with a string' do
    let(:config) { { notifications: { hipchat: { rooms: 'room' } } } }
    it { expect(hipchat).to include(rooms: ['room']) }
  end

  describe 'given a hash with an array' do
    let(:config) { { notifications: { hipchat: { rooms: ['room'] } } } }
    it { expect(hipchat).to include(rooms: ['room']) }
  end

  describe 'given a hash with an unknown template var' do
    let(:config) { { notifications: { hipchat: { rooms: 'room', template: ['%{wat}'] } } } }
    it { expect(hipchat[:template]).to be_nil }
    it { expect(msgs).to include [:error, :'notifications.hipchat', :unknown_var, 'unknown template variable "wat"'] }
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { hipchat: { callback.to_sym => value } } } }
            it { expect(hipchat[callback.to_sym]).to eq value }
          end
        end
      end

      describe "inherits shared #{callback}" do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { hipchat: { rooms: 'room' }, callback.to_sym => value } } }
            it { expect(hipchat[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end
end
