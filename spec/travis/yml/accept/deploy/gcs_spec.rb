describe Travis::Yml, 'gcs' do
  subject { described_class.load(yaml) }

  describe 'key_file' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gcs
          key_file: str
      )
      it { should serialize_to deploy: [provider: 'gcs', key_file: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'access_key_id' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: gcs
          access_key_id:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'gcs', access_key_id: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'secret_access_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: gcs
          secret_access_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'gcs', secret_access_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'bucket' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gcs
          bucket: str
      )
      it { should serialize_to deploy: [provider: 'gcs', bucket: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'upload_dir' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gcs
          upload_dir: str
      )
      it { should serialize_to deploy: [provider: 'gcs', upload_dir: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'local_dir' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gcs
          local_dir: str
      )
      it { should serialize_to deploy: [provider: 'gcs', local_dir: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'dot_match' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: gcs
          dot_match: true
      )
      it { should serialize_to deploy: [provider: 'gcs', dot_match: true] }
      it { should_not have_msg }
    end
  end

  describe 'acl' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gcs
          acl: str
      )
      it { should serialize_to deploy: [provider: 'gcs', acl: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'cache_control' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gcs
          cache_control: str
      )
      it { should serialize_to deploy: [provider: 'gcs', cache_control: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'detect_encoding' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: gcs
          detect_encoding: true
      )
      it { should serialize_to deploy: [provider: 'gcs', detect_encoding: true] }
      it { should_not have_msg }
    end
  end
end
