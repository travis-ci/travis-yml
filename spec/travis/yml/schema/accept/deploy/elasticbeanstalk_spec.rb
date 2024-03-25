describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:elasticbeanstalk]) }

  describe 'elasticbeanstalk' do
    describe 'access_key_id' do
      it { should validate deploy: { provider: :elasticbeanstalk, access_key_id: 'str' } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, access_key_id: 1 } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, access_key_id: true } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, access_key_id: ['str'] } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, access_key_id: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, access_key_id: [{:foo=>'foo'}] } }
    end

    describe 'securet_access_key' do
      it { should validate deploy: { provider: :elasticbeanstalk, securet_access_key: 'str' } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, securet_access_key: 1 } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, securet_access_key: true } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, securet_access_key: ['str'] } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, securet_access_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, securet_access_key: [{:foo=>'foo'}] } }
    end

    describe 'region' do
      it { should validate deploy: { provider: :elasticbeanstalk, region: 'str' } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, region: 1 } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, region: true } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, region: ['str'] } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, region: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, region: [{:foo=>'foo'}] } }
    end

    describe 'app' do
      it { should validate deploy: { provider: :elasticbeanstalk, app: 'str' } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, app: 1 } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, app: true } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, app: ['str'] } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, app: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, app: [{:foo=>'foo'}] } }
    end

    describe 'env' do
      it { should validate deploy: { provider: :elasticbeanstalk, env: 'str' } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, env: 1 } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, env: true } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, env: ['str'] } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, env: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, env: [{:foo=>'foo'}] } }
    end

    describe 'zip_file' do
      it { should validate deploy: { provider: :elasticbeanstalk, zip_file: 'str' } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, zip_file: 1 } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, zip_file: true } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, zip_file: ['str'] } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, zip_file: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, zip_file: [{:foo=>'foo'}] } }
    end

    describe 'bucket_name' do
      it { should validate deploy: { provider: :elasticbeanstalk, bucket_name: 'str' } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, bucket_name: 1 } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, bucket_name: true } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, bucket_name: ['str'] } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, bucket_name: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, bucket_name: [{:foo=>'foo'}] } }
    end

    describe 'bucket_path' do
      it { should validate deploy: { provider: :elasticbeanstalk, bucket_path: 'str' } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, bucket_path: 1 } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, bucket_path: true } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, bucket_path: ['str'] } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, bucket_path: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :elasticbeanstalk, bucket_path: [{:foo=>'foo'}] } }
    end
  end
end
