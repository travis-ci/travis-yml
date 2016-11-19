describe Travis::Yaml, 'addon: hosts' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.to_h[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'hosts' do
    describe 'given a string' do
      let(:config) { { addons: { hosts: 'foo.dev' } } }
      it { expect(addons[:hosts]).to eq ['foo.dev'] }
    end

    describe 'given an array' do
      let(:config) { { addons: { hosts: ['foo.dev', 'bar.dev'] } } }
      it { expect(addons[:hosts]).to eq ['foo.dev', 'bar.dev'] }
    end
  end
end
