describe Travis::Yml, 'empty' do
  subject { described_class.apply(value) }

  describe 'seq' do
    describe 'given a seq' do
      let(:value) { { os: ['linux', 'osx'] } }
      it { should_not have_msg }
    end

    describe 'given an empty array' do
      let(:value) { { os: [] } }
      it { should have_msg [:warn, :os, :empty] }
    end

    describe 'given nil' do
      let(:value) { { os: nil } }
      it { should have_msg [:warn, :os, :empty] }
    end
  end

  describe 'map' do
    describe 'given a map' do
      let(:value) { { cache: { bundler: true } } }
      it { should_not have_msg }
    end

    describe 'given an empty map' do
      let(:value) { { cache: {} } }
      it { should have_msg [:warn, :cache, :empty] }
    end

    describe 'given nil' do
      let(:value) { { cache: nil } }
      it { should have_msg [:warn, :cache, :empty] }
    end
  end
end
