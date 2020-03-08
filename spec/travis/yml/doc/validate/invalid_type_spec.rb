describe Travis::Yml::Doc::Validate, 'invalid_type', drop: true do
  subject { described_class.apply(build_schema(schema), build_value(value, opts)) }

  describe 'str' do
    let(:schema) { { type: :string } }

    describe 'given a str' do
      let(:value) { 'bar' }
      it { should_not have_msg }
      it { should serialize_to value }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should serialize_to 1 }
      it { should have_msg [:error, :root, :invalid_type, expected: :str, actual: :num, value: value] }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to true }
      it { should have_msg [:error, :root, :invalid_type, expected: :str, actual: :bool, value: value] }
    end

    describe 'given a seq' do
      let(:value) { ['foo', 'bar'] }
      it { should serialize_to nil }
      it { should have_msg [:error, :root, :invalid_type, expected: :str, actual: :seq, value: value] }
    end

    describe 'given a map' do
      let(:value) { { foo: 'bar' } }
      it { should serialize_to nil }
      it { should have_msg [:error, :root, :invalid_type, expected: :str, actual: :map, value: value] }
    end
  end

  describe 'num' do
    let(:schema) { { type: :number } }

    describe 'given a str' do
      let(:value) { 'bar' }
      it { should serialize_to 'bar' }
      it { should have_msg [:error, :root, :invalid_type, expected: :num, actual: :str, value: value] }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should_not have_msg }
      it { should serialize_to value }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to true }
      it { should have_msg [:error, :root, :invalid_type, expected: :num, actual: :bool, value: value] }
    end

    describe 'given a seq' do
      let(:value) { ['foo', 'bar'] }
      it { should serialize_to nil }
      it { should have_msg [:error, :root, :invalid_type, expected: :num, actual: :seq, value: value] }
    end

    describe 'given a map' do
      let(:value) { { foo: 'bar' } }
      it { should serialize_to nil }
      it { should have_msg [:error, :root, :invalid_type, expected: :num, actual: :map, value: value] }
    end
  end

  describe 'bool' do
    let(:schema) { { type: :boolean } }

    describe 'given a str' do
      let(:value) { 'bar' }
      it { should serialize_to 'bar' }
      it { should have_msg [:error, :root, :invalid_type, expected: :bool, actual: :str, value: value] }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should serialize_to 1 }
      it { should have_msg [:error, :root, :invalid_type, expected: :bool, actual: :num, value: value] }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a seq' do
      let(:value) { ['foo', 'bar'] }
      it { should serialize_to nil }
      it { should have_msg [:error, :root, :invalid_type, expected: :bool, actual: :seq, value: value] }
    end

    describe 'given a map' do
      let(:value) { { foo: 'bar' } }
      it { should serialize_to nil }
      it { should have_msg [:error, :root, :invalid_type, expected: :bool, actual: :map, value: value] }
    end
  end

  describe 'secure' do
    let(:schema) { Travis::Yml.schema[:definitions][:type][:secure] }

    describe 'given a str' do
      let(:value) { 'bar' }
      it { should serialize_to value }
      it { should have_msg [:alert, :root, :secure, type: :str] }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should serialize_to nil }
      it { should have_msg [:error, :root, :invalid_type, expected: :secure, actual: :num, value: value] }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to nil }
      it { should have_msg [:error, :root, :invalid_type, expected: :secure, actual: :bool, value: value] }
    end

    describe 'given a secure (plain)' do
      let(:value) { { secure: 'str' } }
      it { should serialize_to value }
      it { should have_msg [:warn, :'root.secure', :invalid_secure, value: value] }
    end

    describe 'given a secure (base64)' do
      let(:value) { { secure: Base64.encode64('str') } }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a seq' do
      let(:value) { ['foo', 'bar'] }
      it { should serialize_to nil }
      it { should have_msg [:error, :root, :invalid_type, expected: :secure, actual: :seq, value: value] }
    end

    describe 'given a map' do
      let(:value) { { foo: 'bar' } }
      it { should serialize_to nil }
      it { should have_msg [:error, :root, :invalid_type, expected: :secure, actual: :map, value: value] }
    end
  end

  describe 'seq' do
    let(:schema) { { type: :array, items: { type: :string } } }

    describe 'given a str' do
      let(:value) { 'bar' }
      it { should serialize_to [] }
      it { should have_msg [:error, :root, :invalid_type, expected: :seq, actual: :str, value: value] }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should serialize_to [] }
      it { should have_msg [:error, :root, :invalid_type, expected: :seq, actual: :num, value: value] }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to [] }
      it { should have_msg [:error, :root, :invalid_type, expected: :seq, actual: :bool, value: value] }
    end

    describe 'given a seq' do
      let(:value) { ['foo', 'bar'] }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a map' do
      let(:value) { { foo: 'bar' } }
      it { should serialize_to [] }
      it { should have_msg [:error, :root, :invalid_type, expected: :seq, actual: :map, value: value] }
    end
  end

  describe 'map' do
    let(:schema) { { type: :object, properties: { foo: { type: :string } } } }

    describe 'given a str' do
      let(:value) { 'bar' }
      it { should serialize_to empty }
      it { should have_msg [:error, :root, :invalid_type, expected: :map, actual: :str, value: value] }
    end

    describe 'given a num' do
      let(:value) { 1 }
      it { should serialize_to empty }
      it { should have_msg [:error, :root, :invalid_type, expected: :map, actual: :num, value: value] }
    end

    describe 'given a bool' do
      let(:value) { true }
      it { should serialize_to empty }
      it { should have_msg [:error, :root, :invalid_type, expected: :map, actual: :bool, value: value] }
    end

    describe 'given a seq' do
      let(:value) { ['foo', 'bar'] }
      it { should serialize_to empty }
      it { should have_msg [:error, :root, :invalid_type, expected: :map, actual: :seq, value: value] }
    end

    describe 'given a map' do
      let(:value) { { foo: 'bar' } }
      it { should serialize_to value }
      it { should_not have_msg }
    end
  end
end
