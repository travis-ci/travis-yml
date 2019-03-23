describe Travis::Yaml, 'addon: homebrew' do
  let(:msgs)   { subject.msgs }
  let(:addons) { subject.serialize[:addons] }

  subject { described_class.apply(input.merge(language: 'ruby')) }

  describe 'packages' do
    let(:input) { { addons: { homebrew: { packages: packages } } } }

    describe 'given a string' do
      let(:packages) { 'package' }
      it { expect(addons[:homebrew][:packages]).to eq ['package'] }
    end

    describe 'given an array' do
      let(:packages) { ['package'] }
      it { expect(addons[:homebrew][:packages]).to eq ['package'] }
    end

    describe 'given a nested array (happens when using aliases)' do
      let(:packages) { [['foo', 'bar']] }
      it { expect(addons[:homebrew][:packages]).to  eq ['foo', 'bar'] }
    end

    xit describe 'given wild nested arrays (using yaml aliases)' do
      let(:packages) { [[['a', 'b'], 'c', 'd'], 'e'] }
      it { expect(addons[:homebrew][:packages]).to eq ['a', 'b', 'c', 'd', 'e'] }
      it { expect(msgs).to include [:warn, :'addons.homebrew.packages', :invalid_seq, value: packages] }
    end
  end

  describe 'casks' do
    let(:input) { { addons: { homebrew: { casks: casks } } } }

    describe 'given a string' do
      let(:casks) { 'package' }
      it { expect(addons[:homebrew][:casks]).to eq ['package'] }
    end

    describe 'given an array' do
      let(:casks) { ['package'] }
      it { expect(addons[:homebrew][:casks]).to eq ['package'] }
    end

    describe 'given a nested array (happens when using aliases)' do
      let(:casks) { [['foo', 'bar']] }
      it { expect(addons[:homebrew][:casks]).to  eq ['foo', 'bar'] }
    end

    xit describe 'given wild nested arrays (using yaml aliases)' do
      let(:casks) { [[['a', 'b'], 'c', 'd'], 'e'] }
      it { expect(addons[:homebrew][:casks]).to eq ['a', 'b', 'c', 'd', 'e'] }
      it { expect(msgs).to include [:warn, :'addons.homebrew.casks', :invalid_seq, value: casks] }
    end
  end

  describe 'taps' do
    let(:input) { { addons: { homebrew: { taps: taps } } } }

    describe 'given a string' do
      let(:taps) { 'package' }
      it { expect(addons[:homebrew][:taps]).to eq ['package'] }
    end

    describe 'given an array' do
      let(:taps) { ['package'] }
      it { expect(addons[:homebrew][:taps]).to eq ['package'] }
    end

    describe 'given a nested array (happens when using aliases)' do
      let(:taps) { [['foo', 'bar']] }
      it { expect(addons[:homebrew][:taps]).to  eq ['foo', 'bar'] }
    end

    xit describe 'given wild nested arrays (using yaml aliases)' do
      let(:taps) { [[['a', 'b'], 'c', 'd'], 'e'] }
      it { expect(addons[:homebrew][:taps]).to eq ['a', 'b', 'c', 'd', 'e'] }
      it { expect(msgs).to include [:warn, :'addons.homebrew.taps', :invalid_seq, value: taps] }
    end
  end

  describe 'update' do
    let(:input) { { addons: { homebrew: { update: update } } } }

    describe 'given a bool' do
      let(:update) { true }
      it { expect(addons[:homebrew][:update]).to be true }
    end

    describe 'given a string' do
      let(:update) { 'true' }
      it { expect(addons[:homebrew][:update]).to be true }
    end
  end

  describe 'brewfile' do
    let(:input) { { addons: { homebrew: { brewfile: brewfile } } } }

    describe 'given a bool' do
      let(:brewfile) { true }
      it { expect(addons[:homebrew][:brewfile]).to eq 'true' }
    end

    describe 'given a string' do
      let(:brewfile) { 'files/Brewfile.travis' }
      it { expect(addons[:homebrew][:brewfile]).to eq 'files/Brewfile.travis' }
    end
  end
end
