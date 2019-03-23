describe Travis::Yaml, 'notifications: email' do
  let(:email) { subject.serialize[:notifications][:email] }

  subject { described_class.apply(input) }

  describe 'given an empty hash' do
    let(:input) { { notifications: { email: {} } } }
    it { expect(subject.serialize[:notifications]).to be_nil }
  end

  describe 'disabled via false' do
    let(:input) { { notifications: { email: false } } }
    it { expect(email).to eq(enabled: false) }
  end

  describe 'disabled via disabled: true' do
    let(:input) { { notifications: { email: { disabled: true } } } }
    it { expect(email).to eq(enabled: false) }
    it { expect(msgs).to be_empty }
  end

  describe 'disabled via enabled: false' do
    let(:input) { { notifications: { email: { enabled: false } } } }
    it { expect(email).to eq(enabled: false) }
  end

  describe 'enabled by default' do
    let(:input) { { notifications: { email: { recipients: 'example@rkh.im' } } } }
    it { expect(email).to include(enabled: true) }
  end

  describe 'enabled via true' do
    let(:input) { { notifications: { email: true } } }
    it { expect(email).to eq(enabled: true) }
  end

  describe 'enabled via enabled: true' do
    let(:input) { { notifications: { email: { enabled: true } } } }
    it { expect(email).to eq(enabled: true) }
  end

  describe 'enabled via disabled: false' do
    let(:input) { { notifications: { email: { disabled: false } } } }
    it { expect(email).to eq(enabled: true) }
  end

  describe 'enabled via both email: false, and disabled: false' do
    let(:input) { { notifications: { email: false, disabled: false } } }
    it { expect(email).to eq(enabled: false) }
    it { expect(msgs).to_not include [:error, :'notifications.email.template', :misplaced_key, key: :disabled, value: false] }
  end

  describe 'recipients' do
    let(:recipients) { email[:recipients] }

    describe 'given a string' do
      let(:input) { { notifications: { email: 'me@rkh.im' } } }
      it { expect(recipients).to eq ['me@rkh.im'] }
    end

    describe 'given an array' do
      let(:input) { { notifications: { email: ['me@rkh.im'] } } }
      it { expect(recipients).to eq ['me@rkh.im'] }
    end

    describe 'given an array with a hash' do
      let(:input) { { notifications: { email: [{ recipients: ['me@rkh.im'] }] } } }
      it { expect(recipients).to eq ['me@rkh.im'] }
    end

    describe 'given an array with a secure' do
      let(:input) { { notifications: { email: { recipients: [secure: 'secure'] } } } }
      it { expect(recipients).to eq [secure: 'secure'] }
    end

    describe 'given a hash with a string' do
      let(:input) { { notifications: { email: { recipients: 'me@rkh.im' } } } }
      it { expect(recipients).to eq ['me@rkh.im'] }
    end

    describe 'given a hash with an array' do
      let(:input) { { notifications: { email: { recipients: ['me@rkh.im'] } } } }
      it { expect(recipients).to eq ['me@rkh.im'] }
    end

    describe 'does not prefix with :email, given a hash with an unknown key' do
      let(:input) { { notifications: { foo: 'foo' } } }
      it { expect(subject.serialize[:notifications]).to be_nil }
      it { expect(msgs).to include [:error, :notifications, :unknown_key, key: :foo, value: 'foo'] }
    end

    describe 'prefixes with :email, given a hash with the key :recipients, and a string' do
      let(:input) { { notifications: { recipients: 'me@rkh.im' } } }
      it { expect(email).to eq recipients: ['me@rkh.im'], enabled: true }
    end

    describe 'prefixes with :email, given a hash with the key :recipients, and an array' do
      let(:input) { { notifications: { recipients: ['me@rkh.im'] } } }
      it { expect(email).to eq recipients: ['me@rkh.im'], enabled: true }
    end

    describe 'prefixes with :email, given a hash with the key :recipients, and a key :email' do
      let(:input) { { notifications: { recipients: ['me@rkh.im'], email: { on_success: 'always' } } } }
      it { expect(email).to eq enabled: true, recipients: ['me@rkh.im'], on_success: 'always' }
    end

    describe 'prefixes with :recipients, given a string' do
      let(:input) { { notifications: { email: 'me@rkh.im' } } }
      it { expect(email).to eq recipients: ['me@rkh.im'], enabled: true }
    end

    describe 'prefixes with :recipients, given an array' do
      let(:input) { { notifications: { email: ['me@rkh.im'] } } }
      it { expect(recipients).to eq ['me@rkh.im'] }
    end

    describe 'does not prefix with :recipients, given a hash' do
      let(:input) { { notifications: { email: { foo: 'foo' } } } }
      it { expect(email).to eq enabled: true }
      it { expect(msgs).to include [:error, :'notifications.email', :unknown_key, key: :foo, value: 'foo'] }
    end

    describe 'does not prefix with :recipients, given a mixed array of hashes and strings' do
      let(:input) { { notifications: { email: ['me@rkh.im', on_success: 'change'] } } }
      it { expect(email).to eq enabled: true, recipients: ['me@rkh.im'], on_success: 'change' }
    end

    describe 'does not prefix with :recipients, given a mixed array of hashes and secure' do
      let(:input) { { notifications: { email: [{ secure: 'secure' }, { on_success: 'change' }] } } }
      it { expect(email).to eq enabled: true, recipients: [{ secure: 'secure' }], on_success: 'change' }
    end

    describe 'misplaced email, with notifications.email being false' do
      let(:input) { { notifications: { email: false }, email: 'me@rkh.im' } }
      it { expect(email).to eq enabled: true, recipients: ['me@rkh.im'] }
    end

    describe 'prefixable key recipients, with notifications.email being present' do
      let(:input) { { notifications: { recipients: ['me@rkh.im'], email: { on_success: 'change' } } } }
      it { expect(email).to eq enabled: true, recipients: ['me@rkh.im'], on_success: 'change' }
      it { expect(msgs).to include [:warn, :notifications, :migrate, key: :recipients, to: :email, value: ['me@rkh.im']] }
    end
  end

  describe 'callbacks' do
    %w(on_success on_failure).each do |callback|
      describe callback do
        %w(always never change).each do |value|
          describe 'accepts %p' % value do
            let(:input) { { notifications: { email: { callback.to_sym => value }, enabled: true } } }
            it { expect(email[callback.to_sym]).to eq value }
          end
        end
      end
    end
  end

  describe 'emails (alias)' do
    let(:input) { { notification: { emails: 'me@email.com' } } }
    it { expect(email).to eq recipients: ['me@email.com'], enabled: true }
  end
end
