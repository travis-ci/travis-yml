describe Travis::Yaml, 'deploy lambda' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:access_key_id)     { 'access_key_id' }
  let(:secret_access_key) { 'secret_access_key' }

  let(:input) do
    {
      deploy: {
        provider: 'lambda',
        access_key_id: access_key_id,
        secret_access_key: secret_access_key,
        region: 'region',
        function_name: 'function_name',
        role: 'role',
        handler_name: 'handler_name',
        module_name: 'module_name',
        zip: 'zip',
        description: 'description',
        timeout: '0',
        memory_size: '0',
        runtime: 'runtime',
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
