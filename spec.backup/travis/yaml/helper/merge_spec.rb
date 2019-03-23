describe Travis::Yaml::Helper::Merge do
  subject { described_class.apply(one, two) }

  describe 'given a hash' do
    describe 'and another hash' do
      let(:one) { { foo: :foo } }
      let(:two) { { bar: :bar } }
      it { should eq foo: :foo, bar: :bar }
    end

    describe 'with a hash' do
      let(:one) { { foo: { bar: { baz: :baz } } } }

      describe 'and another hash with a hash' do
        let(:two) { { foo: { bar: { buz: :buz } } } }
        it { should eq foo: { bar: { baz: :baz, buz: :buz } } }
      end

      describe 'and another hash with an array' do
        let(:two) { { foo: [:baz] } }
        it { should eq foo: { bar: { baz: :baz } } }
      end

      describe 'and another hash with a scalar' do
        let(:two) { { foo: :baz } }
        it { should eq foo: { bar: { baz: :baz } } }
      end
    end

    describe 'with an array' do
      let(:one) { { foo: [:foo] } }

      describe 'and another hash with a hash' do
        let(:two) { { foo: { bar: :bar } } }
        it { should eq foo: [:foo, bar: :bar] }
      end

      describe 'and another hash with an array' do
        let(:two) { { foo: [:bar] } }
        it { should eq foo: [:foo, :bar] }
      end

      describe 'and another hash with a scalar' do
        let(:two) { { foo: :bar } }
        it { should eq foo: [:foo, :bar] }
      end
    end

    describe 'with a scalar' do
      let(:one) { { foo: :foo } }

      describe 'and another hash with a hash' do
        let(:two) { { foo: { bar: :bar } } }
        it { should eq foo: :foo }
      end

      describe 'and another hash with an array' do
        let(:two) { { foo: [:bar] } }
        it { should eq foo: :foo }
      end

      describe 'and another hash with a scalar' do
        let(:two) { { foo: :bar } }
        it { should eq foo: :foo }
      end
    end
  end

  describe 'given an array' do
    let(:one) { [:foo] }

    describe 'and another array' do
      let(:two) { [:bar] }
      it { should eq [:foo, :bar] }
    end

    describe 'and a hash' do
      let(:two) { { bar: :bar } }
      it { should eq [:foo, bar: :bar] }
    end

    describe 'and a scalar' do
      let(:two) { :bar }
      it { should eq [:foo, :bar] }
    end
  end
end
