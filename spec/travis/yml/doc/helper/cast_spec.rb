describe Travis::Yml::Doc::Cast do
  let(:cast) { described_class.new(value, type) }

  describe 'a str' do
    describe 'to :str' do
      let(:type) { :str }

      describe 'foo' do
        let(:value) { 'foo' }
        it { expect(cast.apply).to eq 'foo' }
      end
    end

    describe 'to :num' do
      let(:type) { :num }

      describe 'foo' do
        let(:value) { 'foo' }
        it { expect(cast.apply).to eq 'foo' }
      end

      describe '"1"' do
        let(:value) { '1' }
        it { expect(cast.apply).to eq 1 }
      end

      describe '"1.1"' do
        let(:value) { '1.1.' }
        it { expect(cast.apply).to eq 1.1 }
      end
    end

    describe 'to :bool' do
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
        it { expect(cast.apply).to be 0 }
      end

      describe '1' do
        let(:value) { 1 }
        it { expect(cast.apply).to be 1 }
      end

      describe '0.0' do
        let(:value) { 0.0 }
        it { expect(cast.apply).to be 0.0 }
      end

      describe '1.0' do
        let(:value) { 1.0 }
        it { expect(cast.apply).to be 1.0 }
      end

      describe '"false"' do
        let(:value) { 'false' }
        it { expect(cast.apply).to be false }
      end

      describe '"true"' do
        let(:value) { 'true' }
        it { expect(cast.apply).to be true }
      end

      describe 'any string' do
        let(:value) { 'foo' }
        it { expect(cast.apply).to eq 'foo' }
      end

      # %w(ture tru true# true/ .true true;).each do |str|
      #   describe str do
      #     let(:value) { str }
      #     it { expect(cast.apply).to be true }
      #   end
      # end
      #
      # %w(fakse fals false, false` falsedc flase).each do |str|
      #   describe str do
      #     let(:value) { str }
      #     it { expect(cast.apply).to be false }
      #   end
      # end
    end
  end

  describe 'a symbol' do
    let(:value) { :foo }

    describe 'to :str' do
      let(:type) { :str }
      it { expect(cast.apply).to eq 'foo' }
    end

    describe 'to :num' do
      let(:type) { :num }
      it { expect(cast.apply).to eq :foo }
    end

    describe 'to :bool' do
      let(:type) { :bool }
      it { expect(cast.apply).to eq true }
    end
  end

  describe 'an integer' do
    let(:value) { 1 }

    describe 'to :str' do
      let(:type) { :str }
      it { expect(cast.apply).to eq '1' }
    end

    describe 'to :num' do
      let(:type) { :num }
      it { expect(cast.apply).to eq 1 }
    end

    describe 'to :bool' do
      let(:type) { :bool }

      describe '1' do
        it { expect(cast.apply).to be 1 }
      end

      describe '0' do
        let(:value) { 0 }
        it { expect(cast.apply).to be 0 }
      end
    end
  end

  describe 'a float' do
    let(:value) { 1.1 }

    describe 'to :str' do
      let(:type) { :str }
      it { expect(cast.apply).to eq '1.1' }
    end

    describe 'to :num' do
      let(:type) { :num }
      it { expect(cast.apply).to eq 1.1 }
    end

    describe 'to :bool' do
      let(:type) { :bool }

      describe '1.1' do
        it { expect(cast.apply).to be 1.1 }
      end

      describe '0.0' do
        let(:value) { 0.0 }
        it { expect(cast.apply).to be 0.0 }
      end
    end
  end

  describe 'a bool' do
    describe 'to str' do
      let(:type) { :str }

      describe 'true' do
        let(:value) { true }
        it { expect(cast.apply).to eq 'true' }
      end

      describe 'false' do
        let(:value) { false }
        it { expect(cast.apply).to eq 'false' }
      end
    end

    describe 'to num' do
      let(:type) { :num }

      describe 'true' do
        let(:value) { true }
        it { expect(cast.apply).to be true }
      end

      describe 'false' do
        let(:value) { false }
        it { expect(cast.apply).to be false }
      end
    end

    describe 'to bool' do
      let(:type) { :bool }

      describe 'true' do
        let(:value) { true }
        it { expect(cast.apply).to be true }
      end

      describe 'false' do
        let(:value) { false }
        it { expect(cast.apply).to be false }
      end
    end
  end
end
