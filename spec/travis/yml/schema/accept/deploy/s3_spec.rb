describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:s3]) }

  describe 's3' do
    describe 'access_key_id' do
      it { should validate deploy: { provider: :s3, access_key_id: 'str' } }
      it { should_not validate deploy: { provider: :s3, access_key_id: 1 } }
      it { should_not validate deploy: { provider: :s3, access_key_id: true } }
      it { should_not validate deploy: { provider: :s3, access_key_id: ['str'] } }
      it { should_not validate deploy: { provider: :s3, access_key_id: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, access_key_id: [{:foo=>'foo'}] } }
    end

    describe 'secret_access_key' do
      it { should validate deploy: { provider: :s3, secret_access_key: 'str' } }
      it { should_not validate deploy: { provider: :s3, secret_access_key: 1 } }
      it { should_not validate deploy: { provider: :s3, secret_access_key: true } }
      it { should_not validate deploy: { provider: :s3, secret_access_key: ['str'] } }
      it { should_not validate deploy: { provider: :s3, secret_access_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, secret_access_key: [{:foo=>'foo'}] } }
    end

    describe 'bucket' do
      it { should validate deploy: { provider: :s3, bucket: 'str' } }
      it { should_not validate deploy: { provider: :s3, bucket: 1 } }
      it { should_not validate deploy: { provider: :s3, bucket: true } }
      it { should_not validate deploy: { provider: :s3, bucket: ['str'] } }
      it { should_not validate deploy: { provider: :s3, bucket: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, bucket: [{:foo=>'foo'}] } }
    end

    describe 'region' do
      it { should validate deploy: { provider: :s3, region: 'str' } }
      it { should_not validate deploy: { provider: :s3, region: 1 } }
      it { should_not validate deploy: { provider: :s3, region: true } }
      it { should_not validate deploy: { provider: :s3, region: ['str'] } }
      it { should_not validate deploy: { provider: :s3, region: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, region: [{:foo=>'foo'}] } }
    end

    describe 'upload_dir' do
      it { should validate deploy: { provider: :s3, upload_dir: 'str' } }
      it { should_not validate deploy: { provider: :s3, upload_dir: 1 } }
      it { should_not validate deploy: { provider: :s3, upload_dir: true } }
      it { should_not validate deploy: { provider: :s3, upload_dir: ['str'] } }
      it { should_not validate deploy: { provider: :s3, upload_dir: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, upload_dir: [{:foo=>'foo'}] } }
    end

    describe 'storage_class' do
      it { should validate deploy: { provider: :s3, storage_class: 'str' } }
      it { should_not validate deploy: { provider: :s3, storage_class: 1 } }
      it { should_not validate deploy: { provider: :s3, storage_class: true } }
      it { should_not validate deploy: { provider: :s3, storage_class: ['str'] } }
      it { should_not validate deploy: { provider: :s3, storage_class: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, storage_class: [{:foo=>'foo'}] } }
    end

    describe 'local_dir' do
      it { should validate deploy: { provider: :s3, local_dir: 'str' } }
      it { should_not validate deploy: { provider: :s3, local_dir: 1 } }
      it { should_not validate deploy: { provider: :s3, local_dir: true } }
      it { should_not validate deploy: { provider: :s3, local_dir: ['str'] } }
      it { should_not validate deploy: { provider: :s3, local_dir: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, local_dir: [{:foo=>'foo'}] } }
    end

    describe 'detect_encoding' do
      it { should validate deploy: { provider: :s3, detect_encoding: true } }
      it { should_not validate deploy: { provider: :s3, detect_encoding: 1 } }
      it { should_not validate deploy: { provider: :s3, detect_encoding: 'str' } }
      it { should_not validate deploy: { provider: :s3, detect_encoding: ['str'] } }
      it { should_not validate deploy: { provider: :s3, detect_encoding: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, detect_encoding: [{:foo=>'foo'}] } }
    end

    describe 'cache_control' do
      it { should validate deploy: { provider: :s3, cache_control: 'str' } }
      it { should_not validate deploy: { provider: :s3, cache_control: 1 } }
      it { should_not validate deploy: { provider: :s3, cache_control: true } }
      it { should_not validate deploy: { provider: :s3, cache_control: ['str'] } }
      it { should_not validate deploy: { provider: :s3, cache_control: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, cache_control: [{:foo=>'foo'}] } }
    end

    describe 'expires' do
      it { should validate deploy: { provider: :s3, expires: 'str' } }
      it { should_not validate deploy: { provider: :s3, expires: 1 } }
      it { should_not validate deploy: { provider: :s3, expires: true } }
      it { should_not validate deploy: { provider: :s3, expires: ['str'] } }
      it { should_not validate deploy: { provider: :s3, expires: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, expires: [{:foo=>'foo'}] } }
    end

    describe 'acl' do
      it { should validate deploy: { provider: :s3, acl: 'str' } }
      it { should_not validate deploy: { provider: :s3, acl: 1 } }
      it { should_not validate deploy: { provider: :s3, acl: true } }
      it { should_not validate deploy: { provider: :s3, acl: ['str'] } }
      it { should_not validate deploy: { provider: :s3, acl: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, acl: [{:foo=>'foo'}] } }
    end

    describe 'dot_match' do
      it { should validate deploy: { provider: :s3, dot_match: true } }
      it { should_not validate deploy: { provider: :s3, dot_match: 1 } }
      it { should_not validate deploy: { provider: :s3, dot_match: 'str' } }
      it { should_not validate deploy: { provider: :s3, dot_match: ['str'] } }
      it { should_not validate deploy: { provider: :s3, dot_match: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, dot_match: [{:foo=>'foo'}] } }
    end

    describe 'index_document_suffix' do
      it { should validate deploy: { provider: :s3, index_document_suffix: 'str' } }
      it { should_not validate deploy: { provider: :s3, index_document_suffix: 1 } }
      it { should_not validate deploy: { provider: :s3, index_document_suffix: true } }
      it { should_not validate deploy: { provider: :s3, index_document_suffix: ['str'] } }
      it { should_not validate deploy: { provider: :s3, index_document_suffix: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, index_document_suffix: [{:foo=>'foo'}] } }
    end

    describe 'default_text_charset' do
      it { should validate deploy: { provider: :s3, default_text_charset: 'str' } }
      it { should_not validate deploy: { provider: :s3, default_text_charset: 1 } }
      it { should_not validate deploy: { provider: :s3, default_text_charset: true } }
      it { should_not validate deploy: { provider: :s3, default_text_charset: ['str'] } }
      it { should_not validate deploy: { provider: :s3, default_text_charset: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, default_text_charset: [{:foo=>'foo'}] } }
    end

    describe 'server_side_encryption' do
      it { should validate deploy: { provider: :s3, server_side_encryption: true } }
      it { should_not validate deploy: { provider: :s3, server_side_encryption: 1 } }
      it { should_not validate deploy: { provider: :s3, server_side_encryption: 'str' } }
      it { should_not validate deploy: { provider: :s3, server_side_encryption: ['str'] } }
      it { should_not validate deploy: { provider: :s3, server_side_encryption: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :s3, server_side_encryption: [{:foo=>'foo'}] } }
    end
  end
end
