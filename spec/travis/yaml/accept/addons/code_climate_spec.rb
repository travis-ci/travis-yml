describe Travis::Yaml, 'addon: code_climate' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.serialize[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'given a string' do
    let(:config) { { addons: { code_climate: 'token' } } }
    it { expect(addons[:code_climate]).to eq(repo_token: 'token') }
  end

  describe 'given a secure string' do
    let(:config) { { addons: { code_climate: { secure: 'token' } } } }
    it { expect(addons[:code_climate]).to eq(repo_token: { secure: 'token' }) }
  end

  describe 'given a hash with a string' do
    let(:config) { { addons: { code_climate: { repo_token: 'token' } } } }
    it { expect(addons[:code_climate]).to eq(repo_token: 'token') }
  end

  describe 'given a hash with a secure string' do
    let(:config) { { addons: { code_climate: { repo_token: { secure: 'token' } } } } }
    it { expect(addons[:code_climate]).to eq(repo_token: { secure: 'token' }) }
  end
end
