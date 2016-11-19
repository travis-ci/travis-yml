describe Travis::Yaml, 'notifications: irc' do
  let(:msgs) { subject.msgs }
  let(:irc)  { subject.to_h[:notifications][:irc] }

  subject { described_class.apply(config) }

  describe 'given a string' do
    let(:config) { { notifications: { irc: 'channel' } } }
    it { expect(irc).to include(channels: ['channel']) }
  end

  describe 'given an array' do
    let(:config) { { notifications: { irc: ['channel', 'another'] } } }
    it { expect(irc).to include(channels: ['channel', 'another']) }
  end

  describe 'given a hash with a string' do
    let(:config) { { notifications: { irc: { channels: 'channel' } } } }
    it { expect(irc).to include(channels: ['channel']) }
  end

  describe 'given a hash with an array' do
    let(:config) { { notifications: { irc: { channels: ['channel', 'another'] } } } }
    it { expect(irc).to include(channels: ['channel', 'another']) }
  end

  describe 'given a hash with an unknown template var' do
    let(:config) { { notifications: { irc: { channels: 'channel', template: ['%{wat}'] } } } }
    it { expect(irc[:template]).to be_nil }
    it { expect(msgs).to include [:error, :'notifications.irc', :unknown_var, 'unknown template variable "wat"'] }
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { irc: { callback.to_sym => value } } } }
            it { expect(irc[callback.to_sym]).to eq value }
          end
        end
      end

      describe "inherits shared #{callback}" do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { irc: { channels: 'channel' }, callback.to_sym => value } } }
            it { expect(irc[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end
end
