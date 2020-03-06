describe Travis::Yml::Doc::Validate, 'empty', empty: true do
  subject { described_class.apply(build_schema(schema), build_value(value, opts)) }

  describe 'str' do
    let(:schema) { { type: :string } }

    describe 'given a str' do
      let(:value) { 'bar' }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given an empty str' do
      let(:value) { '' }
      # it { should serialize_to nil }
      # it { should have_msg [:warn, :root, :empty]}
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given nil' do
      let(:value) { nil }
      # it { should serialize_to nil }
      # it { should have_msg [:warn, :root, :empty]}
      it { should serialize_to value }
      it { should_not have_msg }
    end
  end

  describe 'num' do
    let(:schema) { { type: :number } }

    describe 'given 0' do
      let(:value) { 0 }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given 1' do
      let(:value) { 1 }
      it { should serialize_to value }
      it { should_not have_msg }
    end
  end

  describe 'bool' do
    let(:schema) { { type: :boolean } }

    describe 'given true' do
      let(:value) { true }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given false' do
      let(:value) { false }
      it { should serialize_to value }
      it { should_not have_msg }
    end
  end

  describe 'seq' do
    let(:schema) { { type: :array, items: { type: :string } } }

    describe 'given a seq' do
      let(:value) { ['foo'] }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given an empty seq' do
      let(:value) { [] }
      it { should serialize_to [] }
      it { should have_msg [:warn, :root, :empty, key: 'root']}
    end
  end

  describe 'map' do
    let(:schema) { { type: :object, properties: { foo: { type: :string } } } }

    describe 'given a map' do
      let(:value) { { foo: 'foo' } }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given an empty map' do
      let(:value) { {} }
      it { should serialize_to({}) }
      it { should have_msg [:warn, :root, :empty, key: 'root']}
    end
  end
end
