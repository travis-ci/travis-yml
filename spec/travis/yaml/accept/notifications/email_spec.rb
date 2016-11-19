describe Travis::Yaml, 'notifications: email' do
  let(:msgs)  { subject.msgs }
  let(:email) { subject.to_h[:notifications][:email] }

  subject { described_class.apply(config) }

  describe 'disabled via false' do
    let(:config) { { notifications: { email: false } } }
    it { expect(email).to eq(enabled: false) }
  end

  describe 'disabled via disabled: true' do
    let(:config) { { notifications: { email: { disabled: true } } } }
    it { expect(email).to eq(enabled: false) }
  end

  describe 'disabled via enabled: false' do
    let(:config) { { notifications: { email: { enabled: false } } } }
    it { expect(email).to eq(enabled: false) }
  end

  describe 'enabled by default' do
    let(:config) { { notifications: { email: { recipients: 'example@rkh.im' } } } }
    it { expect(email).to include(enabled: true) }
  end

  describe 'enabled via true' do
    let(:config) { { notifications: { email: true } } }
    it { expect(email).to eq(enabled: true) }
  end

  describe 'enabled via enabled: true' do
    let(:config) { { notifications: { email: { enabled: true } } } }
    it { expect(email).to eq(enabled: true) }
  end

  describe 'enabled via disabled: false' do
    let(:config) { { notifications: { email: { disabled: false } } } }
    it { expect(email).to eq(enabled: true) }
  end

  describe 'recipients' do
    let(:recipients) { email[:recipients] }

    describe 'given a string' do
      let(:config) { { notifications: { email: 'me@rkh.im' } } }
      it { expect(recipients).to eq ['me@rkh.im'] }
    end

    describe 'given an array' do
      let(:config) { { notifications: { email: ['me@rkh.im'] } } }
      it { expect(recipients).to eq ['me@rkh.im'] }
    end

    describe 'given a hash with a string' do
      let(:config) { { notifications: { email: { recipients: 'me@rkh.im' } } } }
      it { expect(recipients).to eq ['me@rkh.im'] }
    end

    describe 'given an hash with an array' do
      let(:config) { { notifications: { email: { recipients: ['me@rkh.im'] } } } }
      it { expect(recipients).to eq ['me@rkh.im'] }
    end
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:config) { { notifications: { email: { callback.to_sym => value } } } }
            it { expect(email[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end
end
