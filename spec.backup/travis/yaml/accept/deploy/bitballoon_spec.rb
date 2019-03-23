describe Travis::Yaml, 'deploy bitballoon' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'bitballoon',
        access_token: access_token,
        site_id: 'site_id',
        local_dir: 'local_dir',
      }
    }
  end

  describe 'access_token given as a string' do
    let(:access_token) { 'access_token' }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'access_token given as a secure string' do
    let(:access_token) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end
