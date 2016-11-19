describe Travis::Yaml, 'deploy nodejitsu' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'nodejitsu',
        username: 'username',
        api_key: api_key,
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
