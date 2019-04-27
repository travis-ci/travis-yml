describe Travis::Yml::Doc::Change::Prefix do
  subject { described_class.new(build_schema(schema), build_value(value)).apply }

  let(:schema) do
    {
      type: :object,
      properties: {
        foo: {
          type: :string
        },
        bar: {
          type: :string
        },
      },
      prefix: prefix
    }
  end

  describe 'types' do
    let(:prefix) { { key: :foo } }

    describe 'given a str' do
      let(:value) { 'foo' }
      it { should serialize_to foo: 'foo' }
      it { should_not have_msg }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should serialize_to foo: '1' }
      it { should have_msg [:info, :foo, :cast, given_value: 1, given_type: :num, value: '1', type: :str] }
    end

    describe 'given a seq of strs' do
      let(:value) { ['foo', 'bar'] }
      it { should serialize_to foo: 'foo' }
      it { should have_msg [:warn, :foo, :invalid_seq, value: 'foo'] }
    end

    describe 'given a map with the prefix key' do
      let(:value) { { foo: 'str' } }
      it { should serialize_to foo: 'str' }
    end

    describe 'given a map with a known key' do
      let(:value) { { bar: 'str' } }
      it { should serialize_to bar: 'str' }
    end

    describe 'given a map with an unknown key' do
      let(:value) { { baz: 'str' } }
      it { should serialize_to baz: 'str' }
    end
  end

  describe 'given prefix :only' do
    let(:prefix) { { key: :foo, only: [:str] } }

    describe 'given a str' do
      let(:value) { 'foo' }
      it { should serialize_to foo: 'foo' }
      it { should_not have_msg }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should serialize_to 1 }
    end
  end
end
