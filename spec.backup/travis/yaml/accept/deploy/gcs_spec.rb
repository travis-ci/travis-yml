describe Travis::Yaml, 'deploy gcs' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:access_key_id)     { 'access_key_id' }
  let(:secret_access_key) { 'secret_access_key' }

  let(:input) do
    {
      deploy: {
        provider: 'gcs',
        access_key_id: access_key_id,
        secret_access_key: secret_access_key,
        bucket: 'bucket',
        upload_dir: 'upload_dir',
        local_dir: 'local_dir',
        dot_match: true,
        acl: 'acl',
        cache_control: 'cache_control',
        detect_encoding: true,
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
