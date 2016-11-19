describe Travis::Yaml, 'deploy opsworks' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:access_key_id)     { 'access_key_id' }
  let(:secret_access_key) { 'secret_access_key' }

  let(:input) do
    {
      deploy: {
        provider: 'opsworks',
        access_key_id: access_key_id,
        secret_access_key: secret_access_key,
        app_id: 'app_id',
        instance_ids: 'instance_ids',
        layer_ids: 'layer_ids',
        migrate: true,
        wait_until_deployed: 'wait_until_deployed',
        custom_json: 'custom_json',
      }
    }
  end

  describe 'access_key_id, and secret_access_key given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'access_key_id given as a secure string' do
    let(:access_key_id) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'secret_access_key given as a secure string' do
    let(:secret_access_key) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end
