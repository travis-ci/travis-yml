describe Travis::Yml, 'enable' do
  subject { described_class.apply(value) }

  describe 'notifications' do
    describe 'given true' do
      let(:value) { { notifications: true } }
      it { should serialize_to notifications: { email: { enabled: true } } }
      it { should_not have_msg }
    end

    describe 'given yes' do
      let(:value) { { notifications: 'yes' } }
      it { should serialize_to notifications: { email: { enabled: true } } }
      it { should_not have_msg }
    end
  end

  describe 'notifications.email' do
    describe 'given true' do
      let(:value) { { notifications: { email: true } } }
      it { should serialize_to notifications: { email: { enabled: true } } }
      it { should_not have_msg }
    end

    describe 'given yes' do
      let(:value) { { notifications: { email: 'yes' } } }
      it { should serialize_to notifications: { email: { enabled: true } } }
      it { should_not have_msg }
    end
  end

  describe 'given a seq with a hash with a bool' do
    let(:value) { { notifications: [{ email: true }] } }
    it { should serialize_to notifications: { email: { enabled: true } } }
    it { should have_msg [:warn, :notifications, :unexpected_seq, value: { email: true }] }
  end

  describe 'given a seq with a map with a bool on an alias' do
    let(:value) { { notifications: [{ emails: true }] } }
    it { should serialize_to notifications: { email: { enabled: true } } }
    it { should have_msg [:warn, :notifications, :unexpected_seq, value: { email: true }] }
  end
end
