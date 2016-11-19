describe Travis::Yaml, 'deploy elasticbeanstalk' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:access_key_id)     { 'access_key_id' }
  let(:secret_access_key) { 'secret_access_key' }
  let(:env)               { 'env' }

  let(:input) do
    {
      deploy: {
        provider: 'elasticbeanstalk',
        access_key_id: access_key_id,
        securet_access_key: secret_access_key,
        region: 'region',
        app: 'app',
        env: env,
        zip_file: 'zip_file',
        bucket_name: 'bucket_name',
        bucket_path: 'bucket_path',
        only_create_app_version: true
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

  describe 'env given as a hash' do
    let(:env) { { production: 'production', staging: 'staging' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end
