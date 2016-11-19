describe Travis::Yaml, 'addon: postgresql' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.to_h[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'postgresql' do
    let(:config) { { addons: { postgresql: 9.1 } } }
    it { expect(addons[:postgresql]).to eq '9.1' }
  end
end
