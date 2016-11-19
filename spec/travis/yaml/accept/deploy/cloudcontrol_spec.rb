describe Travis::Yaml, 'deploy cloudcontrol' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:email)    { 'email' }
  let(:password) { 'password' }

  let(:input) do
    {
      deploy: {
        provider: 'cloudcontrol',
        email: email,
        password: password,
        deployment: 'deployment',
      }
    }
  end

  describe 'email, and password given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'email given as a secure string' do
    let(:email) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'password given as a secure string' do
    let(:password) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end
