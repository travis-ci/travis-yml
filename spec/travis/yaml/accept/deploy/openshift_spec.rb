describe Travis::Yaml, 'deploy openshift' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:user)     { 'user' }
  let(:password) { 'password' }

  let(:input) do
    {
      deploy: {
        provider: 'openshift',
        user: 'user',
        password: 'password',
        domain: 'domain',
        app: 'app',
        deployment_branch: 'deployment_branch',
      }
    }
  end

  describe 'user, and password given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'user given as a secure string' do
    let(:user) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'password given as a secure string' do
    let(:password) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end
