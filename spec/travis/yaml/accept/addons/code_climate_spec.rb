describe Travis::Yaml, 'addon: code_climate' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.to_h[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'code_climate' do
    let(:config) { { addons: { code_climate: { repo_token: 'token' } } } }
    it { expect(addons[:code_climate]).to eq(repo_token: 'token') }
  end
end
