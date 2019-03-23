describe Travis::Yaml, 'addon: firefox' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.serialize[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'firefox' do
    let(:config) { { addons: { firefox: 15 } } }
    it { expect(addons[:firefox]).to eq '15' }
  end
end
