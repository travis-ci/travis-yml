describe Travis::Yaml, 'addon: apt' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.to_h[:addons] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'sources' do
    let(:config) { { addons: { apt: { sources: sources } } } }

    describe 'given a string' do
      let(:sources) { 'source' }
      it { expect(addons[:apt][:sources]).to  eq ['source'] }
    end

    describe 'given an array' do
      let(:sources) { ['source'] }
      it { expect(addons[:apt][:sources]).to  eq ['source'] }
    end
  end

  describe 'packages' do
    let(:config) { { addons: { apt: { packages: packages } } } }

    describe 'given a string' do
        let(:packages) { 'package' }
      it { expect(addons[:apt][:packages]).to eq ['package'] }
    end

    describe 'given an array' do
        let(:packages) { ['package'] }
      it { expect(addons[:apt][:packages]).to eq ['package'] }
    end
  end
end
