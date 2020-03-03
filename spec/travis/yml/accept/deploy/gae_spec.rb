describe Travis::Yml, 'gae' do
  subject { described_class.load(yaml) }

  describe 'project' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gae
          project: str
      )
      it { should serialize_to deploy: [provider: 'gae', project: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'keyfile' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gae
          keyfile: str
      )
      it { should serialize_to deploy: [provider: 'gae', keyfile: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'config' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gae
          config: str
      )
      it { should serialize_to deploy: [provider: 'gae', config: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'version' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gae
          version: str
      )
      it { should serialize_to deploy: [provider: 'gae', version: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'promote' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: gae
          promote: true
      )
      it { should serialize_to deploy: [provider: 'gae', promote: true] }
      it { should_not have_msg }
    end
  end

  describe 'stop_previous_version' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: gae
          stop_previous_version: true
      )
      it { should serialize_to deploy: [provider: 'gae', stop_previous_version: true] }
      it { should_not have_msg }
    end
  end

  describe 'verbosity' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gae
          verbosity: str
      )
      it { should serialize_to deploy: [provider: 'gae', verbosity: 'str'] }
      it { should_not have_msg }
    end
  end
end
