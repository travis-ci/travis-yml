describe Travis::Yaml, 'deploy bintray' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:user)       { 'user' }
  let(:passphrase) { 'passphrase' }
  let(:dry_run)    { :dry_run }

  let(:input) do
    {
      deploy: {
        provider: 'bintray',
        file: 'file',
        user: user,
        key: 'key',
        passphrase: passphrase,
        dry_run => true
      }
    }
  end

  describe 'user, and passphrase given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'user given as a secure string' do
    let(:user) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'passphrase given as a secure string' do
    let(:passphrase) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'dry-run (dasherized key)' do
    let(:dry_run) { :'dry-run' }
    it { expect(deploy[0][:dry_run]).to be true }
  end
end
