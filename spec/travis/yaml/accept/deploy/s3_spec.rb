describe Travis::Yaml, 'deploy s3' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:access_key_id)     { 'access_key_id' }
  let(:secret_access_key) { 'secret_access_key' }

  let(:input) do
    {
      deploy: {
        provider: 's3',
        access_key_id: access_key_id,
        secret_access_key: secret_access_key,
        bucket: 'bucket',
        region: 'region',
        upload_dir: 'upload_dir',
        storage_class: 'storage_class',
        local_dir: 'local_dir',
        detect_encoding: true,
        cache_control: 'cache_control',
        expires: 'expires',
        acl: 'acl',
        dot_match: true,
        index_document_suffix: 'index_document_suffix',
        default_text_charset: 'default_text_charset',
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
