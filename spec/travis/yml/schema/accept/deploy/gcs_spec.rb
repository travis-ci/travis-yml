describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:gcs]) }

  describe 'gcs' do
    describe 'access_key_id' do
      it { should validate deploy: { provider: :gcs, access_key_id: 'str' } }
      it { should_not validate deploy: { provider: :gcs, access_key_id: 1 } }
      it { should_not validate deploy: { provider: :gcs, access_key_id: true } }
      it { should_not validate deploy: { provider: :gcs, access_key_id: ['str'] } }
      it { should_not validate deploy: { provider: :gcs, access_key_id: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gcs, access_key_id: [{:foo=>'foo'}] } }
    end

    describe 'secret_access_key' do
      it { should validate deploy: { provider: :gcs, secret_access_key: 'str' } }
      it { should_not validate deploy: { provider: :gcs, secret_access_key: 1 } }
      it { should_not validate deploy: { provider: :gcs, secret_access_key: true } }
      it { should_not validate deploy: { provider: :gcs, secret_access_key: ['str'] } }
      it { should_not validate deploy: { provider: :gcs, secret_access_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gcs, secret_access_key: [{:foo=>'foo'}] } }
    end

    describe 'bucket' do
      it { should validate deploy: { provider: :gcs, bucket: 'str' } }
      it { should_not validate deploy: { provider: :gcs, bucket: 1 } }
      it { should_not validate deploy: { provider: :gcs, bucket: true } }
      it { should_not validate deploy: { provider: :gcs, bucket: ['str'] } }
      it { should_not validate deploy: { provider: :gcs, bucket: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gcs, bucket: [{:foo=>'foo'}] } }
    end

    describe 'upload_dir' do
      it { should validate deploy: { provider: :gcs, upload_dir: 'str' } }
      it { should_not validate deploy: { provider: :gcs, upload_dir: 1 } }
      it { should_not validate deploy: { provider: :gcs, upload_dir: true } }
      it { should_not validate deploy: { provider: :gcs, upload_dir: ['str'] } }
      it { should_not validate deploy: { provider: :gcs, upload_dir: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gcs, upload_dir: [{:foo=>'foo'}] } }
    end

    describe 'local_dir' do
      it { should validate deploy: { provider: :gcs, local_dir: 'str' } }
      it { should_not validate deploy: { provider: :gcs, local_dir: 1 } }
      it { should_not validate deploy: { provider: :gcs, local_dir: true } }
      it { should_not validate deploy: { provider: :gcs, local_dir: ['str'] } }
      it { should_not validate deploy: { provider: :gcs, local_dir: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gcs, local_dir: [{:foo=>'foo'}] } }
    end

    describe 'dot_match' do
      it { should validate deploy: { provider: :gcs, dot_match: true } }
      it { should_not validate deploy: { provider: :gcs, dot_match: 1 } }
      it { should_not validate deploy: { provider: :gcs, dot_match: 'str' } }
      it { should_not validate deploy: { provider: :gcs, dot_match: ['str'] } }
      it { should_not validate deploy: { provider: :gcs, dot_match: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gcs, dot_match: [{:foo=>'foo'}] } }
    end

    describe 'acl' do
      it { should validate deploy: { provider: :gcs, acl: 'str' } }
      it { should_not validate deploy: { provider: :gcs, acl: 1 } }
      it { should_not validate deploy: { provider: :gcs, acl: true } }
      it { should_not validate deploy: { provider: :gcs, acl: ['str'] } }
      it { should_not validate deploy: { provider: :gcs, acl: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gcs, acl: [{:foo=>'foo'}] } }
    end

    describe 'cache_control' do
      it { should validate deploy: { provider: :gcs, cache_control: 'str' } }
      it { should_not validate deploy: { provider: :gcs, cache_control: 1 } }
      it { should_not validate deploy: { provider: :gcs, cache_control: true } }
      it { should_not validate deploy: { provider: :gcs, cache_control: ['str'] } }
      it { should_not validate deploy: { provider: :gcs, cache_control: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gcs, cache_control: [{:foo=>'foo'}] } }
    end

    describe 'detect_encoding' do
      it { should validate deploy: { provider: :gcs, detect_encoding: true } }
      it { should_not validate deploy: { provider: :gcs, detect_encoding: 1 } }
      it { should_not validate deploy: { provider: :gcs, detect_encoding: 'str' } }
      it { should_not validate deploy: { provider: :gcs, detect_encoding: ['str'] } }
      it { should_not validate deploy: { provider: :gcs, detect_encoding: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :gcs, detect_encoding: [{:foo=>'foo'}] } }
    end
  end
end
