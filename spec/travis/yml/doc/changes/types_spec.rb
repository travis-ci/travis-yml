describe Travis::Yml::Doc::Change, 'various types' do
  let(:str)    { { type: :string } }
  let(:strs)   { { type: :array, items: { type: :string } } }
  let(:obj)    { { type: :object, properties: { bar: str }, prefix: :bar } }
  let(:objs)   { { type: :array, items: obj } }

  subject { described_class.apply(build_schema(schema), build_value(value)) }

  describe 'str to seq of str' do
    let(:schema) { { type: :object, properties: { foo: { anyOf: [strs, str] } } } }

    describe 'given a str' do
      let(:value) { { foo: 'foo' } }
      it { should serialize_to foo: ['foo'] }
      it { should_not have_msg }
    end

    describe 'given a seq of strs' do
      let(:value) { { foo: ['foo'] } }
      it { should serialize_to foo: ['foo'] }
      it { should_not have_msg }
    end

    describe 'given a seq of objs' do
      let(:value) { { foo: [bar: 'bar'] } }
      it { should serialize_to value }
      it { should_not have_msg }
    end
  end

  describe 'str to map' do
    let(:schema) { { type: :object, properties: { foo: { anyOf: [obj, str] } } } }

    describe 'given a str' do
      let(:value) { { foo: 'foo' } }
      it { should serialize_to foo: { bar: 'foo' } }
      it { should_not have_msg }
    end

    describe 'given a seq of strs' do
      let(:value) { { foo: ['foo'] } }
      it { should serialize_to foo: { bar: 'foo' } }
      it { should have_msg [:warn, :'foo.bar', :invalid_seq, value: 'foo'] }
    end
  end

  describe 'str to seq of maps' do
    let(:schema) { { type: :object, properties: { foo: { anyOf: [objs] } } } }

    describe 'given a str' do
      let(:value) { { foo: 'foo' } }
      it { should serialize_to foo: [bar: 'foo'] }
      it { should_not have_msg }
    end

    describe 'given a seq of strs' do
      let(:value) { { foo: ['foo'] } }
      it { should serialize_to foo: [bar: 'foo'] }
      it { should_not have_msg }
    end
  end

  describe 'array of strs to str' do
    let(:schema) { { type: :object, properties: { foo: { type: :string } } } }
    let(:value) { { foo: ['foo', 'bar'] } }
    it { should serialize_to foo: 'foo' }
    it { should have_msg [:warn, :foo, :invalid_seq, value: 'foo'] }
  end
end
