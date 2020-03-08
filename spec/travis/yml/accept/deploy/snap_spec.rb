describe Travis::Yml, 'snap' do
  subject { described_class.load(yaml) }

  describe 'snap' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: snap
          snap: str
      )
      it { should serialize_to deploy: [provider: 'snap', snap: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'snap' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: snap
          channel: str
      )
      it { should serialize_to deploy: [provider: 'snap', channel: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'cleanup' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: snap
          cleanup: true
      )
      it { should serialize_to deploy: [provider: 'snap', cleanup: true] }
      it { should_not have_msg }
    end
  end

  describe 'token' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: snap
          token: str
      )
      it { should serialize_to deploy: [provider: 'snap', token: 'str'] }
      it { should_not have_msg }
    end

    describe 'given a secure' do
      yaml %(
        deploy:
          provider: snap
          token:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'snap', token: { secure: secure }] }
      it { should_not have_msg }
    end
  end
end
