describe Travis::Yaml, 'deploy modulus' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'modulus',
        api_key: api_key,
        project_name: 'project_name',
      }
    }
  end

  describe 'api_key given as a string' do
    let(:api_key) { 'api_key' }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'api_key given as a secure string' do
    let(:api_key) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end
