describe Travis::Yml, 'openshift' do
  subject { described_class.apply(parse(yaml)) }

  describe 'server' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: openshift
          server: str
      )
      it { should serialize_to deploy: [provider: 'openshift', server: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: openshift
          token:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'openshift', token: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'project' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: openshift
          project: str
      )
      it { should serialize_to deploy: [provider: 'openshift', project: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: openshift
          app: str
      )
      it { should serialize_to deploy: [provider: 'openshift', app: 'str'] }
      it { should_not have_msg }
    end
  end
end
