describe Travis::Yml::Doc::Validate, 'unknown_value' do
  subject { described_class.apply(build_schema(schema), build_value(value, opts)) }

  describe 'enum' do
    let(:schema) { { type: :string, enum: ['foo'] } }

    describe 'given a known value' do
      let(:value) { 'foo' }
      it { should serialize_to 'foo' }
      it { should_not have_msg }
    end

    describe 'given an unknown value' do
      let(:value) { 'bar' }

      describe 'drop turned off (default)' do
        it { should serialize_to value }
        it { should have_msg [:error, :root, :unknown_value, value: 'bar'] }
      end

      describe 'drop turned off on', drop: true do
        it { should serialize_to nil }
        it { should have_msg [:error, :root, :unknown_value, value: 'bar'] }
      end
    end
  end

  describe 'enum with a default' do
    let(:schema) { { type: :string, enum: ['foo'], defaults: [value: 'foo'] } }

    describe 'given a known value' do
      let(:value) { 'foo' }
      it { should serialize_to 'foo' }
      it { should_not have_msg }
    end

    describe 'given an unknown value' do
      let(:value) { 'bar' }

      describe 'drop turned off (default)' do
        it { should serialize_to 'foo' }
        it { should have_msg [:warn, :root, :unknown_default, value: 'bar', default: 'foo'] }
      end

      describe 'drop turned off on', drop: true do
        it { should serialize_to 'foo' }
        it { should have_msg [:warn, :root, :unknown_default, value: 'bar', default: 'foo'] }
      end
    end
  end
end
