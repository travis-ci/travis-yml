describe Travis::Yaml, 'notifications: irc' do
  let(:irc)  { subject.serialize[:notifications][:irc] }

  subject { described_class.apply(input) }

  describe 'given a string' do
    let(:input) { { notifications: { irc: 'channel' } } }
    it { expect(irc).to include(channels: ['channel']) }
  end

  describe 'given an array' do
    let(:input) { { notifications: { irc: ['channel', 'another'] } } }
    it { expect(irc).to include(channels: ['channel', 'another']) }
  end

  describe 'given a hash with a string' do
    let(:input) { { notifications: { irc: { channels: 'channel' } } } }
    it { expect(irc).to include(channels: ['channel']) }
  end

  describe 'given a hash with an array' do
    let(:input) { { notifications: { irc: { channels: ['channel', 'another'] } } } }
    it { expect(irc).to include(channels: ['channel', 'another']) }
  end

  describe 'given a hash with an unknown template var' do
    let(:input) { { notifications: { irc: { channels: 'channel', template: ['%{wat}'] } } } }
    it { expect(irc[:template]).to be_nil }
    it { expect(msgs).to include [:error, :'notifications.irc.template', :unknown_var, var: 'wat'] }
  end

  describe 'given a string with a misplaced key on the parent' do
    let(:input) { { notifications: { irc: 'channel', use_notice: true } } }
    # would have to prefix before migrating
    xit { expect(irc).to eq channels: ['channel'], enabled: true, use_notice: true }
    it { expect(irc).to eq enabled: true, use_notice: true }
    it { expect(msgs).to include [:warn, :notifications, :migrate, key: :use_notice, to: :irc, value: true] }
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:input) { { notifications: { irc: { callback.to_sym => value } } } }
            it { expect(irc[callback.to_sym]).to eq value }
          end
        end
      end

      describe "inherits shared #{callback}" do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:input) { { notifications: { irc: { channels: 'channel' }, callback.to_sym => value } } }
            it { expect(irc[callback.to_sym]).to eq value }
          end
        end
      end
    end

    describe 'given an array' do
      let(:input) { { notifications: { irc: 'channel', on_success: ['always'] } } }
      it { expect(irc).to eq channels: ['channel'], on_success: 'always', enabled: true }
    end
  end
end
