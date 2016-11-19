describe Travis::Yaml::Doc::Validate::InvalidType do
  let(:msgs) { node.msgs }
  let(:node) { build(nil, :key, value) }
  let(:cast) { nil }

  subject { described_class.new(spec, node, {}) }
  before  { subject.apply }

  describe 'wants a scalar' do
    let(:spec) { Travis::Yaml::Doc::Spec::Scalar.new(nil, cast: cast) }

    describe 'given a hash for :str' do
      let(:value) { { foo: 'foo' } }
      let(:cast)  { :str }

      it { expect(node.serialize).to be_nil }
      it { expect(msgs).to include [:error, :key, :invalid_type, expected: :str, actual: :map, value: { foo: 'foo' }] }
    end

    describe 'given a hash for :bool' do
      let(:value) { { foo: 'foo' } }
      let(:cast)  { :bool }

      it { expect(node.serialize).to be_nil }
      it { expect(msgs).to include [:error, :key, :invalid_type, expected: :bool, actual: :map, value: { foo: 'foo' }] }
    end

    describe 'given an array of bools for :str' do
      let(:value) { [true] }
      let(:cast)  { :str }

      it { expect(node.serialize).to be nil }
      it { expect(msgs).to include [:error, :key, :invalid_type, expected: :str, actual: :seq, value: [true]] }
    end

    describe 'given an array of strings for :bool' do
      let(:value) { ['foo'] }
      let(:cast)  { :bool }

      it { expect(node.serialize).to be nil }
      it { expect(msgs).to include [:error, :key, :invalid_type, expected: :bool, actual: :seq, value: ['foo']] }
    end

    describe 'given a string for :bool' do
      let(:value) { 'foo' }
      let(:cast)  { :bool }

      it { expect(node.serialize).to be_nil }
      it { expect(msgs).to include [:error, :key, :invalid_type, expected: :bool, actual: :str, value: 'foo'] }
    end
  end

  describe 'wants a map' do
    let(:spec) { Travis::Yaml::Doc::Spec::Map.new(nil, cast: cast) }

    describe 'given a scalar' do
      let(:value) { 'foo' }
      it { expect(node.serialize).to be_nil }
      it { expect(msgs).to include [:error, :key, :invalid_type, expected: :map, actual: :str, value: 'foo'] }
    end

    describe 'given a seq' do
      let(:value) { ['foo'] }
      it { expect(node.serialize).to be_nil }
      it { expect(msgs).to include [:error, :key, :invalid_type, expected: :map, actual: :seq, value: ['foo']] }
    end
  end

  describe 'wants a seq' do
    let(:spec) { Travis::Yaml::Doc::Spec::Seq.new(nil, cast: cast) }

    describe 'given a scalar' do
      let(:value) { 'foo' }
      it { expect(node.serialize).to be_nil }
      it { expect(msgs).to include [:error, :key, :invalid_type, expected: :seq, actual: :str, value: 'foo'] }
    end

    describe 'given a map' do
      let(:value) { { foo: 'foo' } }
      it { expect(node.serialize).to be_nil }
      it { expect(msgs).to include [:error, :key, :invalid_type, expected: :seq, actual: :map, value: { foo: 'foo' }] }
    end
  end
end
