describe Travis::Yaml, 'deploy npm' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:email)   { 'email' }
  let(:api_key) { 'api_key' }

  let(:input) do
    {
      deploy: {
        provider: 'npm',
        email: email,
        api_key: api_key,
      }
    }
  end

  describe 'email, and api_key given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'email given as a secure string' do
    let(:email) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'api_key given as a secure string' do
    let(:api_key) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end
