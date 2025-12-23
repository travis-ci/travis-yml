describe Travis::Yml, 'accept msteams' do
  subject { described_class.schema }

  describe 'msteams' do
    describe 'enabled' do
      it { should validate notifications: { msteams: { enabled: true } } }
      it { should_not validate notifications: { msteams: { enabled: 1 } } }
    end

    describe 'disabled' do
      it { should validate notifications: { msteams: { disabled: true } } }
      it { should_not validate notifications: { msteams: { disabled: 1 } } }
    end

    describe 'rooms' do
      it { should validate notifications: { msteams: { rooms: 'https://outlook.office.com/webhook/test' } } }
      it { should validate notifications: { msteams: { rooms: ['https://outlook.office.com/webhook/test'] } } }
      it { should_not validate notifications: { msteams: { rooms: 1 } } }
      it { should_not validate notifications: { msteams: { rooms: true } } }
    end

    describe 'on_pull_requests' do
      it { should validate notifications: { msteams: { on_pull_requests: true } } }
      it { should validate notifications: { msteams: { on_pull_requests: false } } }
      it { should_not validate notifications: { msteams: { on_pull_requests: 1 } } }
    end

    describe 'on_success' do
      it { should validate notifications: { msteams: { on_success: 'always' } } }
      it { should validate notifications: { msteams: { on_success: 'never' } } }
      it { should validate notifications: { msteams: { on_success: 'change' } } }
      it { should_not validate notifications: { msteams: { on_success: 1 } } }
    end

    describe 'on_failure' do
      it { should validate notifications: { msteams: { on_failure: 'always' } } }
      it { should validate notifications: { msteams: { on_failure: 'never' } } }
      it { should validate notifications: { msteams: { on_failure: 'change' } } }
      it { should_not validate notifications: { msteams: { on_failure: 1 } } }
    end

    describe 'given a string' do
      it { should validate notifications: { msteams: 'https://outlook.office.com/webhook/test' } }
    end

    describe 'given an array' do
      it { should validate notifications: { msteams: ['https://outlook.office.com/webhook/test'] } }
    end
  end
end
