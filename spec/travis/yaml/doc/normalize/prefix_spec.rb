describe Travis::Yaml::Doc::Normalize::Prefix do
  let(:spec)   { { prefix: prefix, map: map } }
  let(:result) { described_class.new(nil, spec, :key, value).apply }
  let(:map)    { nil }

  describe 'given a prefix without a type' do
    let(:prefix) { { key: :prefix } }

    describe 'given true' do
      let(:value) { true }
      it { expect(result).to eq prefix: true }
    end

    describe 'given an array' do
      let(:value)  { [:foo] }
      it { expect(result).to eq prefix: [:foo] }
    end

    describe 'given a hash' do
      let(:value)  { { foo: :foo} }
      it { expect(result).to eq prefix: { foo: :foo } }
    end

    describe 'given a prefixed hash' do
      let(:value)  { { prefix: :foo} }
      it { expect(result).to eq prefix: :foo }
    end

    describe 'given a mapped hash' do
      let(:map)    { { foo: :foo } }
      let(:value)  { { foo: :foo} }
      it { expect(result).to eq foo: :foo }
    end
  end

  describe 'given a prefix with a type :scalar' do
    let(:prefix) { { key: :prefix, type: :scalar } }

    describe 'given true' do
      let(:value) { true }
      it { expect(result).to eq prefix: true }
    end

    describe 'given an array' do
      let(:value)  { [:foo] }
      it { expect(result).to eq [:foo] }
    end

    describe 'given a hash' do
      let(:value)  { { foo: :foo} }
      it { expect(result).to eq foo: :foo }
    end
  end

  describe 'given a prefix with a type :seq' do
    let(:prefix) { { key: :prefix, type: :seq } }

    describe 'given true' do
      let(:value) { true }
      it { expect(result).to eq true }
    end

    describe 'given an array' do
      let(:value)  { [:foo] }
      it { expect(result).to eq prefix: [:foo] }
    end

    describe 'given a hash' do
      let(:value)  { { foo: :foo} }
      it { expect(result).to eq foo: :foo }
    end
  end

  describe 'given a prefix with a type :map' do
    let(:prefix) { { key: :prefix, type: :map } }

    describe 'given true' do
      let(:value) { true }
      it { expect(result).to eq true }
    end

    describe 'given an array' do
      let(:value)  { [:foo] }
      it { expect(result).to eq [:foo] }
    end

    describe 'given a hash' do
      let(:value)  { { foo: :foo} }
      it { expect(result).to eq prefix: { foo: :foo } }
    end

    describe 'given a prefixed hash' do
      let(:value)  { { prefix: :foo} }
      it { expect(result).to eq prefix: :foo }
    end

    describe 'given a mapped hash' do
      let(:map)    { { foo: :foo } }
      let(:value)  { { foo: :foo} }
      it { expect(result).to eq foo: :foo }
    end
  end
end
