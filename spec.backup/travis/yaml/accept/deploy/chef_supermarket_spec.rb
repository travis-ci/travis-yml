describe Travis::Yaml, 'deploy chef supermarket' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:user_id)   { 'user_id' }
  let(:client_key) { 'client_key' }

  let(:input) do
    {
      deploy: {
        provider: 'chef_supermarket',
        user_id: user_id,
        client_key: client_key,
        cookbook_category: 'cookbook_category',
      }
    }
  end

  describe 'user_id, and client_key given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'user_id given as a secure string' do
    let(:user_id) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'client_key given as a secure string' do
    let(:client_key) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end
