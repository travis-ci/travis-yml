describe Travis::Yaml::Doc::Cast do
  let(:cast) { described_class.new(value, types) }

  describe 'apply?' do
    let(:types) { [:str] }

    describe 'given a string' do
      let(:value) { 'foo' }
      it { expect(cast.apply?).to be false }
    end

    describe 'given true' do
      let(:value) { true }
      it { expect(cast.apply?).to be true }
    end
  end

  describe 'casting to :bool' do
    let(:types) { [:bool] }

    describe 'true' do
      let(:value) { true }
      it { expect(cast.apply).to eq true }
    end

    describe 'false' do
      let(:value) { false }
      it { expect(cast.apply).to eq false }
    end

    describe '0' do
      let(:value) { 0 }
      it { expect(cast.apply).to eq false }
    end

    describe '1' do
      let(:value) { 1 }
      it { expect(cast.apply).to eq true }
    end

    describe '0.0' do
      let(:value) { 0.0 }
      it { expect(cast.apply).to eq false }
    end

    describe '1.0' do
      let(:value) { 1.0 }
      it { expect(cast.apply).to eq true }
    end

    describe '"false"' do
      let(:value) { 'false' }
      it { expect(cast.apply).to eq false }
    end

    describe '"true"' do
      let(:value) { 'true' }
      it { expect(cast.apply).to eq true }
    end

    describe 'a symbol' do
      let(:value) { :foo }
      it { expect(cast.apply).to eq true }
    end
  end

  describe 'casting to :str' do
    let(:types) { [:str] }

    describe 'true' do
      let(:value) { true }
      it { expect(cast.apply).to eq 'true' }
    end

    describe 'false' do
      let(:value) { false }
      it { expect(cast.apply).to eq 'false' }
    end

    describe '1' do
      let(:value) { 1 }
      it { expect(cast.apply).to eq '1' }
    end

    describe '1.0' do
      let(:value) { 1.0 }
      it { expect(cast.apply).to eq '1.0' }
    end

    describe 'a string' do
      let(:value) { 'foo' }
      it { expect(cast.apply).to eq 'foo' }
    end

    describe 'a symbol' do
      let(:value) { :foo }
      it { expect(cast.apply).to eq 'foo' }
    end
  end
end
