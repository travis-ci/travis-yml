describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:opsworks]) }

  describe 'opsworks' do
    describe 'access_key_id' do
      it { should validate deploy: { provider: :opsworks, access_key_id: 'str' } }
      it { should_not validate deploy: { provider: :opsworks, access_key_id: 1 } }
      it { should_not validate deploy: { provider: :opsworks, access_key_id: true } }
      it { should_not validate deploy: { provider: :opsworks, access_key_id: ['str'] } }
      it { should_not validate deploy: { provider: :opsworks, access_key_id: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :opsworks, access_key_id: [{:foo=>'foo'}] } }
    end

    describe 'secret_access_key' do
      it { should validate deploy: { provider: :opsworks, secret_access_key: 'str' } }
      it { should_not validate deploy: { provider: :opsworks, secret_access_key: 1 } }
      it { should_not validate deploy: { provider: :opsworks, secret_access_key: true } }
      it { should_not validate deploy: { provider: :opsworks, secret_access_key: ['str'] } }
      it { should_not validate deploy: { provider: :opsworks, secret_access_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :opsworks, secret_access_key: [{:foo=>'foo'}] } }
    end

    describe 'app_id' do
      it { should validate deploy: { provider: :opsworks, app_id: 'str' } }
      it { should_not validate deploy: { provider: :opsworks, app_id: 1 } }
      it { should_not validate deploy: { provider: :opsworks, app_id: true } }
      it { should_not validate deploy: { provider: :opsworks, app_id: ['str'] } }
      it { should_not validate deploy: { provider: :opsworks, app_id: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :opsworks, app_id: [{:foo=>'foo'}] } }
    end

    describe 'instance_ids' do
      it { should validate deploy: { provider: :opsworks, instance_ids: 'str' } }
      it { should_not validate deploy: { provider: :opsworks, instance_ids: 1 } }
      it { should_not validate deploy: { provider: :opsworks, instance_ids: true } }
      it { should_not validate deploy: { provider: :opsworks, instance_ids: ['str'] } }
      it { should_not validate deploy: { provider: :opsworks, instance_ids: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :opsworks, instance_ids: [{:foo=>'foo'}] } }
    end

    describe 'layer_ids' do
      it { should validate deploy: { provider: :opsworks, layer_ids: 'str' } }
      it { should_not validate deploy: { provider: :opsworks, layer_ids: 1 } }
      it { should_not validate deploy: { provider: :opsworks, layer_ids: true } }
      it { should_not validate deploy: { provider: :opsworks, layer_ids: ['str'] } }
      it { should_not validate deploy: { provider: :opsworks, layer_ids: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :opsworks, layer_ids: [{:foo=>'foo'}] } }
    end

    describe 'migrate' do
      it { should validate deploy: { provider: :opsworks, migrate: true } }
      it { should_not validate deploy: { provider: :opsworks, migrate: 1 } }
      it { should_not validate deploy: { provider: :opsworks, migrate: 'str' } }
      it { should_not validate deploy: { provider: :opsworks, migrate: ['str'] } }
      it { should_not validate deploy: { provider: :opsworks, migrate: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :opsworks, migrate: [{:foo=>'foo'}] } }
    end

    describe 'wait_until_deployed' do
      it { should validate deploy: { provider: :opsworks, wait_until_deployed: 'str' } }
      it { should_not validate deploy: { provider: :opsworks, wait_until_deployed: 1 } }
      it { should_not validate deploy: { provider: :opsworks, wait_until_deployed: true } }
      it { should_not validate deploy: { provider: :opsworks, wait_until_deployed: ['str'] } }
      it { should_not validate deploy: { provider: :opsworks, wait_until_deployed: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :opsworks, wait_until_deployed: [{:foo=>'foo'}] } }
    end

    describe 'custom_json' do
      it { should validate deploy: { provider: :opsworks, custom_json: 'str' } }
      it { should_not validate deploy: { provider: :opsworks, custom_json: 1 } }
      it { should_not validate deploy: { provider: :opsworks, custom_json: true } }
      it { should_not validate deploy: { provider: :opsworks, custom_json: ['str'] } }
      it { should_not validate deploy: { provider: :opsworks, custom_json: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :opsworks, custom_json: [{:foo=>'foo'}] } }
    end
  end
end
