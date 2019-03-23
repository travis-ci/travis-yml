describe Travis::Yml::Doc::Change::Map do
  subject { described_class.new(build_schema(schema), build_value(value)).apply }

  describe 'with a str property' do
    let(:schema) do
      {
        type: :object,
        properties: {
          foo: {
            type: :string
          }
        },
        prefix: :foo
      }
    end

    describe 'given a str' do
      let(:value) { 'foo' }
      it { should serialize_to foo: 'foo' }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should serialize_to foo: '1' }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to foo: 'true' }
    end

    describe 'given an array of strs' do
      let(:value) { ['str'] }
      it { should serialize_to foo: 'str' }
    end

    describe 'given an array of nums' do
      let(:value) { [1] }
      it { should serialize_to foo: '1' }
    end

    describe 'given an object' do
      let(:value) { { foo: 'bar' } }
      it { should serialize_to foo: 'bar' }
    end
  end

  describe 'with a seq property' do
    let(:schema) do
      {
        type: :object,
        properties: {
          foo: {
            type: :array,
            items: {
              type: :string
            }
          }
        },
        prefix: :foo
      }
    end

    describe 'given a str' do
      let(:value) { 'foo' }
      it { should serialize_to foo: ['foo'] }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should serialize_to foo: ['1'] }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to foo: ['true'] }
    end

    describe 'given an array of strs' do
      let(:value) { ['str'] }
      it { should serialize_to foo: ['str'] }
    end

    describe 'given an array of nums' do
      let(:value) { [1] }
      it { should serialize_to foo: ['1'] }
    end

    describe 'given an object' do
      let(:value) { { foo: 'bar' } }
      it { should serialize_to foo: ['bar'] }
    end
  end

  describe 'with a nested map property with a seq' do
    let(:schema) { { type: :object, properties: { foo: { type: :object, properties: { bar: { type: :string } }, prefix: :bar } }, prefix: :foo } }
    let(:schema) do
      {
        type: :object,
        properties: {
          foo: {
            type: :object,
            properties: {
              bar: {
                type: :array,
                items: {
                  type: :string
                }
              }
            },
            prefix: :bar
          }
        },
        prefix: :foo
      }
    end

    describe 'given a str' do
      let(:value) { 'foo' }
      it { should serialize_to foo: { bar: ['foo'] } }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should serialize_to foo: { bar: ['1'] } }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to foo: { bar: ['true'] } }
    end

    describe 'given an array of strs' do
      let(:value) { ['str'] }
      it { should serialize_to foo: { bar: ['str'] } }
    end

    describe 'given an array of nums' do
      let(:value) { [1] }
      it { should serialize_to foo: { bar: ['1'] } }
    end

    describe 'given an object (1)' do
      let(:value) { { foo: 'bar' } }
      it { should serialize_to foo: { bar: ['bar'] } }
    end

    describe 'given an object (2)' do
      let(:value) { { bar: 'bar' } }
      it { should serialize_to foo: { bar: ['bar'] } }
    end
  end
end
