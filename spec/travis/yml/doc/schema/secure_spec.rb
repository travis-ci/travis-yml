describe Travis::Yml::Doc::Schema::Secure do
  let(:schema) do
    build_schema(
      anyOf: [
        {
          type: :object,
          properties: {
            secure: {
              type: :string
            }
          },
          additionalProperties: false
        },
        {
          type: :string
        }
      ]
    )
  end

  describe 'matches?' do
    subject { schema.matches?(build_value(value)) }

    describe 'given a str' do
      let(:value) { 'str' }
      it { should be true }
    end

    describe 'given a secure' do
      let(:value) { { secure: 'str' } }
      it { should be true }
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

    describe 'given a map' do
      let(:value) { { foo: 'foo' } }
      it { should be false }
    end
  end
end
