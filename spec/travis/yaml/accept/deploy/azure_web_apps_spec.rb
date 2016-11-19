describe Travis::Yaml, 'deploy azure web apps' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:username) { 'username' }
  let(:password) { 'password' }

  let(:input) do
    {
      deploy: {
        provider: 'azure_web_apps',
        site: 'site',
        slot: 'slot',
        username: username,
        password: password,
        verbose: true
      }
    }
  end

  describe 'username, and password given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'username given as a secure string' do
    let(:username) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'password given as a secure string' do
    let(:password) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end
