describe Travis::Yaml, 'root' do
  let(:notifications) { subject.serialize[:notifications] }

  subject { described_class.apply(input, {}) }

  describe 'given nil' do
    let(:input) { { notifications: nil } }
    it { expect(notifications).to be_nil }
    it { expect(msgs).to include [:warn, :root, :empty, key: :notifications] }
  end

  describe 'given false' do
    let(:input) { { notifications: false } }
    it { expect(notifications).to eq email: { enabled: false } }
    it { expect(msgs).to be_empty }
  end

  describe 'given emails (alias)' do
    let(:input) { { notifications: { emails: false } } }
    it { expect(notifications).to eq email: { enabled: false } }
    it { expect(info).to include [:info, :notifications, :alias, alias: :emails, key: :email] }
    it { expect(msgs).to be_empty }
  end

  describe 'given emaik (typo)' do
    let(:input) { { notifications: { emailk: false } } }
    it { expect(notifications).to eq email: { enabled: false } }
    it { expect(msgs).to include [:warn, :notifications, :find_key, original: :emailk, key: :emails] }
  end

  describe 'given true' do
    let(:input) { { notifications: { email: false } } }
    it { expect(notifications).to eq email: { enabled: false } }
    it { expect(msgs).to be_empty }
  end

  describe 'given an array' do
    let(:input) { { notifications: [{ email: 'me@email.com' }] } }
    it { expect(notifications).to eq email: { recipients: ['me@email.com'], enabled: true } }
    it { expect(msgs).to include [:warn, :notifications, :invalid_seq, value: { email: 'me@email.com' }] }
  end

  describe 'given an array with a hash' do
    let(:input) { { notifications: [email: false] } }
    it { expect(notifications).to eq email: { enabled: false } }
  end

  describe 'given an array with a hash (alias)' do
    let(:input) { { notifications: [emails: false] } }
    it { expect(notifications).to eq email: { enabled: false } }
  end

  describe 'notification (alias)' do
    let(:input) { { notification: { email: 'me@email.com' } } }
    it { expect(notifications).to eq email: { recipients: ['me@email.com'], enabled: true } }
    it { expect(msgs).to include [:warn, :root, :find_key, original: :notification, key: :notifications] }
  end

  describe 'selects change for :change' do
    let(:input) { { notification: { on_success: ':change' } } }
    it { expect(notifications).to eq on_success: 'change' }
    it { expect(msgs).to include [:warn, :'notifications.on_success', :find_value, original: ':change', value: 'change'] }
  end

  describe 'on_failure given true' do
    let(:input) { { notifications: { email: true, on_failure: true } } }
    it { expect(notifications).to eq email: { enabled: true, on_failure: 'always' }, on_failure: 'always' }
    it { expect(info).to include [:info, :'notifications.on_failure', :alias, alias: 'true', value: 'always'] }
  end

  describe 'given on-sucsess (typo, dasherized)' do
    let(:input) { { notifications: { email: { recipients: 'm@email.com', :'on-sucsess' => 'change', on_failure: 'always' } } } }
    it { expect(notifications).to eq email: { recipients: ['m@email.com'], on_success: 'change', on_failure: 'always', enabled: true } }
    it { expect(msgs).to include [:warn, :'notifications.email', :find_key, original: :'on-sucsess', key: :on_success] }
  end

  describe 'array with hashes' do
    let(:input) { { notifications: { slack: [{ on_success: 'always' }] } } }
    it { expect(notifications).to eq slack: { enabled: true, on_success: 'always' } }
  end

  describe 'array with two hashes with the same key' do
    let(:input) { { notifications: [{ slack: 'foo' }, { slack: 'bar' }] } }
    it { expect(notifications).to eq slack: { rooms: ['foo'], enabled: true } }
  end

  describe 'array with email: true, and irc: channel' do
    let(:input) { { notifications: [{ email: true }, { irc: 'channel' }] } }
    it { expect(notifications).to eq email: { enabled: true }, irc: { channels: ['channel'], enabled: true } }
  end
end
