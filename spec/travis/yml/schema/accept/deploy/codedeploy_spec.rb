describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:codedeploy]) }

  describe 'codedeploy' do
    describe 'access_key_id' do
      it { should validate deploy: { provider: :codedeploy, access_key_id: 'str' } }
      it { should_not validate deploy: { provider: :codedeploy, access_key_id: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, access_key_id: true } }
      it { should_not validate deploy: { provider: :codedeploy, access_key_id: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, access_key_id: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, access_key_id: [{:foo=>'foo'}] } }
    end

    describe 'secret_access_key' do
      it { should validate deploy: { provider: :codedeploy, secret_access_key: 'str' } }
      it { should_not validate deploy: { provider: :codedeploy, secret_access_key: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, secret_access_key: true } }
      it { should_not validate deploy: { provider: :codedeploy, secret_access_key: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, secret_access_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, secret_access_key: [{:foo=>'foo'}] } }
    end

    describe 'application' do
      it { should validate deploy: { provider: :codedeploy, application: 'str' } }
      it { should_not validate deploy: { provider: :codedeploy, application: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, application: true } }
      it { should_not validate deploy: { provider: :codedeploy, application: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, application: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, application: [{:foo=>'foo'}] } }
    end

    describe 'deployment_group' do
      it { should validate deploy: { provider: :codedeploy, deployment_group: 'str' } }
      it { should_not validate deploy: { provider: :codedeploy, deployment_group: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, deployment_group: true } }
      it { should_not validate deploy: { provider: :codedeploy, deployment_group: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, deployment_group: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, deployment_group: [{:foo=>'foo'}] } }
    end

    describe 'revision_type' do
      it { should validate deploy: { provider: :codedeploy, revision_type: 's3' } }
      it { should_not validate deploy: { provider: :codedeploy, revision_type: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, revision_type: true } }
      it { should_not validate deploy: { provider: :codedeploy, revision_type: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, revision_type: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, revision_type: [{:foo=>'foo'}] } }
    end

    describe 'commit_id' do
      it { should validate deploy: { provider: :codedeploy, commit_id: 'str' } }
      it { should_not validate deploy: { provider: :codedeploy, commit_id: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, commit_id: true } }
      it { should_not validate deploy: { provider: :codedeploy, commit_id: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, commit_id: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, commit_id: [{:foo=>'foo'}] } }
    end

    describe 'repository' do
      it { should validate deploy: { provider: :codedeploy, repository: 'str' } }
      it { should_not validate deploy: { provider: :codedeploy, repository: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, repository: true } }
      it { should_not validate deploy: { provider: :codedeploy, repository: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, repository: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, repository: [{:foo=>'foo'}] } }
    end

    describe 'region' do
      it { should validate deploy: { provider: :codedeploy, region: 'str' } }
      it { should_not validate deploy: { provider: :codedeploy, region: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, region: true } }
      it { should_not validate deploy: { provider: :codedeploy, region: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, region: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, region: [{:foo=>'foo'}] } }
    end

    describe 'wait_until_deployed' do
      it { should validate deploy: { provider: :codedeploy, wait_until_deployed: true } }
      it { should_not validate deploy: { provider: :codedeploy, wait_until_deployed: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, wait_until_deployed: 'str' } }
      it { should_not validate deploy: { provider: :codedeploy, wait_until_deployed: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, wait_until_deployed: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, wait_until_deployed: [{:foo=>'foo'}] } }
    end

    describe 'bucket' do
      it { should validate deploy: { provider: :codedeploy, bucket: 'str' } }
      it { should_not validate deploy: { provider: :codedeploy, bucket: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, bucket: true } }
      it { should_not validate deploy: { provider: :codedeploy, bucket: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, bucket: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, bucket: [{:foo=>'foo'}] } }
    end

    describe 'key' do
      it { should validate deploy: { provider: :codedeploy, key: 'str' } }
      it { should_not validate deploy: { provider: :codedeploy, key: 1 } }
      it { should_not validate deploy: { provider: :codedeploy, key: true } }
      it { should_not validate deploy: { provider: :codedeploy, key: ['str'] } }
      it { should_not validate deploy: { provider: :codedeploy, key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :codedeploy, key: [{:foo=>'foo'}] } }
    end
  end
end
