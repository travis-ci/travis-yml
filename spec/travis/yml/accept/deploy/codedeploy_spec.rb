describe Travis::Yml, 'codedeploy' do
  subject { described_class.apply(parse(yaml)) }

  describe 'access_key_id' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: codedeploy
          access_key_id:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'codedeploy', access_key_id: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'secret_access_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: codedeploy
          secret_access_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'codedeploy', secret_access_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'application' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: codedeploy
          application: str
      )
      it { should serialize_to deploy: [provider: 'codedeploy', application: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'deployment_group' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: codedeploy
          deployment_group: str
      )
      it { should serialize_to deploy: [provider: 'codedeploy', deployment_group: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'revision_type' do
    describe 'given a known value' do
      yaml %(
        deploy:
          provider: codedeploy
          revision_type: s3
      )
      it { should serialize_to deploy: [provider: 'codedeploy', revision_type: 's3'] }
      it { should_not have_msg }
    end
  end

  describe 'commit_id' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: codedeploy
          commit_id: str
      )
      it { should serialize_to deploy: [provider: 'codedeploy', commit_id: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'repository' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: codedeploy
          repository: str
      )
      it { should serialize_to deploy: [provider: 'codedeploy', repository: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'region' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: codedeploy
          region: str
      )
      it { should serialize_to deploy: [provider: 'codedeploy', region: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'wait_until_deployed' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: codedeploy
          wait_until_deployed: true
      )
      it { should serialize_to deploy: [provider: 'codedeploy', wait_until_deployed: true] }
      it { should_not have_msg }
    end
  end

  describe 'bucket' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: codedeploy
          bucket: str
      )
      it { should serialize_to deploy: [provider: 'codedeploy', bucket: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'key' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: codedeploy
          key: str
      )
      it { should serialize_to deploy: [provider: 'codedeploy', key: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'description' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: codedeploy
          description: str
      )
      it { should serialize_to deploy: [provider: 'codedeploy', description: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'endpoint' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: codedeploy
          endpoint: str
      )
      it { should serialize_to deploy: [provider: 'codedeploy', endpoint: 'str'] }
      it { should_not have_msg }
    end
  end
end
