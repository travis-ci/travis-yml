describe Travis::Yaml, 'addon: apt' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.serialize[:addons] }

  subject { described_class.apply(input.merge(language: 'ruby')) }

  describe 'packages' do
    let(:input) { { addons: { apt: { packages: packages } } } }

    describe 'given a string' do
      let(:packages) { 'package' }
      it { expect(addons[:apt][:packages]).to eq ['package'] }
    end

    describe 'given an array' do
      let(:packages) { ['package'] }
      it { expect(addons[:apt][:packages]).to eq ['package'] }
    end

    describe 'given a nested array (happens when using aliases)' do
      let(:packages) { [['foo', 'bar']] }
      it { expect(addons[:apt][:packages]).to  eq ['foo', 'bar'] }
    end

    describe 'given wild nested arrays (using yaml aliases)' do
      let(:packages) { [[['a', 'b'], 'c', 'd'], 'e'] }
      it { expect(addons[:apt][:packages]).to eq ['a', 'b', 'c', 'd', 'e'] }
      it { expect(msgs).to include [:warn, :'addons.apt.packages', :invalid_seq, value: packages] }
    end
  end

  describe 'sources' do
    let(:input) { { addons: { apt: { sources: sources } } } }

    describe 'given a string' do
      let(:sources) { 'source' }
      it { expect(addons[:apt][:sources]).to  eq ['source'] }
    end

    describe 'given an array' do
      let(:sources) { [{ name: 'source' }] }
      it { expect(addons[:apt][:sources]).to eq [{ name: 'source' }] }
    end
  end

  describe 'dist' do
    let(:input)   { { addons: { apt: { dist: 'dist' } } } }
    it { expect(addons[:apt][:dist]).to eq 'dist' }
  end

  describe 'prefix, given a string' do
    let(:input) { { addons: { apt: 'package' } } }
    it { expect(addons[:apt][:packages]).to eq ['package'] }
  end

  describe 'prefix, given an array' do
    let(:input) { { addons: { apt: ['package'] } } }
    it { expect(addons[:apt][:packages]).to eq ['package'] }
  end

  describe 'source (alias)' do
    let(:input) { { addons: { apt: { source: 'source' } } } }
    it { expect(addons[:apt][:sources]).to eq ['source'] }
  end

  describe 'package (alias)' do
    let(:input) { { addons: { apt: { package: 'package' } } } }
    it { expect(addons[:apt][:packages]).to  eq ['package'] }
  end
end
