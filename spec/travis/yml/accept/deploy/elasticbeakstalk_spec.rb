describe Travis::Yml, 'elasticbeanstalk' do
  subject { described_class.apply(parse(yaml)) }

  describe 'access_key_id' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          access_key_id:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', access_key_id: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'secret_access_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          secret_access_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', secret_access_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'region' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          region: str
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', region: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'bucket' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          bucket: str
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', bucket: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          app: str
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', app: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'env' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          env: str
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', env: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'zip_file' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          zip_file: str
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', zip_file: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'bucket_name' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          bucket_name: str
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', bucket_name: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'bucket_path' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          bucket_path: str
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', bucket_path: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'description' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          description: str
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', description: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'label' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          label: str
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', label: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'only_create_app_version' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          only_create_app_version: true
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', only_create_app_version: true] }
      it { should_not have_msg }
    end
  end

  describe 'wait_until_deployed' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: elasticbeanstalk
          wait_until_deployed: true
      )
      it { should serialize_to deploy: [provider: 'elasticbeanstalk', wait_until_deployed: true] }
      it { should_not have_msg }
    end
  end
end
