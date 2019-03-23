describe Travis::Yml, 'openshift' do
  subject { described_class.apply(parse(yaml)) }

  describe 'user' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: openshift
          user:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'openshift', user: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: openshift
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'openshift', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'domain' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: openshift
          domain: str
      )
      it { should serialize_to deploy: [provider: 'openshift', domain: 'str'] }
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

  describe 'deployment_branch' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: openshift
          deployment_branch: str
      )
      it { should serialize_to deploy: [provider: 'openshift', deployment_branch: 'str'] }
      it { should_not have_msg }
    end
  end
end
