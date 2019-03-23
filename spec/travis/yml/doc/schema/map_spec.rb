describe Travis::Yml::Doc::Schema, 'map' do
  describe 'strict' do
    let(:schema) do
      described_class.build(
          type: :object,
          properties: {
            foo: {
                type: :string
              }
          },
          aliases: { foo: [:bar] },
          additionalProperties: false
      )
    end

    describe 'matches?' do
      subject { schema.matches?(build_value(value)) }

      describe 'given a str' do
        let(:value) { 'str' }
        it { should be false }
      end

      describe 'given a num' do
        let(:value) { 1 }
        it { should be false }
      end

      describe 'given a bool' do
        let(:value) { true }
        it { should be false }
      end

      describe 'given a none' do
        let(:value) { nil }
        it { should be true }
      end

      describe 'given a seq' do
        let(:value) { ['str'] }
        it { should be false }
      end

      describe 'given a map with a know key and matching type' do
        let(:value) { { foo: 'foo' } }
        it { should be true }
      end

      describe 'given a map with an aliased key and matching type' do
        let(:value) { { bar: 'foo' } }
        it { should be false } # difference between accept? and matches?
      end

      describe 'given a map with a different type' do
        let(:value) { { foo: [1] } }
        it { should be false }
      end

      describe 'given a map with an unknow key' do
        let(:value) { { unknown: 'foo' } }
        it { should be false }
      end
    end
  end

  describe 'not strict, with a type' do
    let(:schema) do
      described_class.build(
        type: :object,
        properties: {
          foo: {
              type: :string
            }
        }
      )
    end
  end

  describe 'not strict, with a pattern and type' do
    let(:schema) do
      described_class.build(
        type: :object,
        patternProperties: {
          '.*': {
            type: :string
          }
        }
      )
    end

    describe 'accept?' do
      subject { schema.matches?(build_value(value)) }

      describe 'given a str' do
        let(:value) { 'str' }
        it { should be false }
      end

      describe 'given a num' do
        let(:value) { 1 }
        it { should be false }
      end

      describe 'given a bool' do
        let(:value) { true }
        it { should be false }
      end

      describe 'given a none' do
        let(:value) { nil }
        it { should be true }
      end

      describe 'given a seq' do
        let(:value) { ['str'] }
        it { should be false }
      end

      describe 'given a map with a know key and matching type' do
        let(:value) { { foo: 'foo' } }
        it { should be true }
      end

      describe 'given a map with a different type' do
        let(:value) { { foo: 1 } }
        it { should be true }
      end
    end
  end
end
