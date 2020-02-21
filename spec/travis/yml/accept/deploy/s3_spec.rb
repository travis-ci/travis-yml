describe Travis::Yml, 's3' do
  subject { described_class.load(yaml) }

  describe 'access_key_id' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: s3
          access_key_id:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 's3', access_key_id: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'secret_access_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: s3
          secret_access_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 's3', secret_access_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'bucket' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          bucket: str
      )
      it { should serialize_to deploy: [provider: 's3', bucket: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'region' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          region: str
      )
      it { should serialize_to deploy: [provider: 's3', region: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'upload_dir' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          upload_dir: str
      )
      it { should serialize_to deploy: [provider: 's3', upload_dir: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'storage_class' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          storage_class: str
      )
      it { should serialize_to deploy: [provider: 's3', storage_class: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'local_dir' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          local_dir: str
      )
      it { should serialize_to deploy: [provider: 's3', local_dir: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'glob' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          glob: str
      )
      it { should serialize_to deploy: [provider: 's3', glob: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'detect_encoding' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: s3
          detect_encoding: true
      )
      it { should serialize_to deploy: [provider: 's3', detect_encoding: true] }
      it { should_not have_msg }
    end
  end

  describe 'cache_control' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          cache_control: str
      )
      it { should serialize_to deploy: [provider: 's3', cache_control: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'expires' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          expires: str
      )
      it { should serialize_to deploy: [provider: 's3', expires: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'acl' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          acl: str
      )
      it { should serialize_to deploy: [provider: 's3', acl: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'dot_match' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: s3
          dot_match: true
      )
      it { should serialize_to deploy: [provider: 's3', dot_match: true] }
      it { should_not have_msg }
    end
  end

  describe 'index_document_suffix' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          index_document_suffix: str
      )
      it { should serialize_to deploy: [provider: 's3', index_document_suffix: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'default_text_charset' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: s3
          default_text_charset: str
      )
      it { should serialize_to deploy: [provider: 's3', default_text_charset: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'server_side_encryption' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: s3
          server_side_encryption: true
      )
      it { should serialize_to deploy: [provider: 's3', server_side_encryption: true] }
      it { should_not have_msg }
    end
  end

  describe 'max_threads' do
    describe 'given a num' do
      yaml %(
        deploy:
          provider: s3
          max_threads: 1
      )
      it { should serialize_to deploy: [provider: 's3', max_threads: 1] }
      it { should_not have_msg }
    end
  end
end
