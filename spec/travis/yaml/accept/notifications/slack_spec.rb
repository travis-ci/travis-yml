describe Travis::Yaml, 'notifications: slack' do
  let(:msgs)  { subject.msgs }
  let(:slack) { subject.to_h[:notifications][:slack] }

  subject { described_class.apply(config) }

  describe 'given a string' do
    let(:config) { { notifications: { slack: 'room' } } }
    it { expect(slack).to include(rooms: ['room']) }
  end

  describe 'given a hash with a string' do
    let(:config) { { notifications: { slack: { rooms: 'room' } } } }
    it { expect(slack).to include(rooms: ['room']) }
  end

  describe 'given a hash with an array' do
    let(:config) { { notifications: { slack: { rooms: ['room'] } } } }
    it { expect(slack).to include(rooms: ['room']) }
  end

  describe 'given a hash with an unknown template var' do
    let(:config) { { notifications: { slack: { rooms: 'room', template: ['%{wat}'] } } } }
    it { expect(slack[:template]).to be_nil }
    it { expect(msgs).to include [:error, :'notifications.slack', :unknown_var, 'unknown template variable "wat"'] }
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { slack: { callback.to_sym => value } } } }
            it { expect(slack[callback.to_sym]).to eq value }
          end
        end
      end

      describe "inherits shared #{callback}" do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { slack: { rooms: 'room' }, callback.to_sym => value } } }
            it { expect(slack[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end
end
