describe Travis::Yaml::Doc::Value::Cast do
  let(:cast) { described_class.new(value, type) }

  describe 'apply?' do
    let(:type) { :str }

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
    let(:type) { :bool }

    describe 'true' do
      let(:value) { true }
      it { expect(cast.apply).to be true }
    end

    describe 'false' do
      let(:value) { false }
      it { expect(cast.apply).to be false }
    end

    describe '0' do
      let(:value) { 0 }
      it { expect(cast.apply).to be false }
    end

    describe '1' do
      let(:value) { 1 }
      it { expect(cast.apply).to be true }
    end

    describe '0.0' do
      let(:value) { 0.0 }
      it { expect(cast.apply).to be false }
    end

    describe '1.0' do
      let(:value) { 1.0 }
      it { expect(cast.apply).to be true }
    end

    describe '"false"' do
      let(:value) { 'false' }
      it { expect(cast.apply).to be false }
    end

    describe '"true"' do
      let(:value) { 'true' }
      it { expect(cast.apply).to be true }
    end

    describe 'a symbol' do
      let(:value) { :foo }
      it { expect(cast.apply).to be true }
    end

    describe 'any string' do
      let(:value) { 'foo' }
      it { expect(cast.apply).to eq true }
    end

    %w(ture tru true# true/ .true true;).each do |value|
      let(:value) { value }
      it { expect(cast.apply).to be false }
    end

    %w(fakse fals false, false` falsedc flase).each do |value|
      let(:value) { value }
      it { expect(cast.apply).to be false }
    end
  end

  describe 'casting to :str' do
    let(:type) { :str }

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
