describe Travis::Yml::Doc::Validate, 'unique' do
  subject { described_class.apply(build_schema(schema), build_value(value)) }

  describe 'seq' do
    let(:schema) do
      {
        type: :array,
        items: {
          type: :object,
          properties: {
            name: {
              type: :string,
              unique: true
            },
            email: {
              type: :string,
              unique: true
            },
            other: {
              type: :string
            }
          }
        }
      }
    end

    describe 'given multiple dupes on one key' do
      let(:value) do
        [
          { name: 'one', other: 'other' },
          { name: 'one', other: 'other' },
          { name: 'two', other: 'other' },
          { name: 'two', other: 'other' }
        ]
      end

      it { should serialize_to value }
      it { should have_msg [:info, :root, :duplicate, duplicates: 'name: one, two'] }
    end

    describe 'given dupes on multiple keys' do
      let(:value) do
        [
          { name: 'one', other: 'other' },
          { name: 'one', other: 'other' },
          { email: 'two', other: 'other' },
          { email: 'two', other: 'other' }
        ]
      end

      it { should serialize_to value }
      it { should have_msg [:info, :root, :duplicate, duplicates: 'name: one, email: two'] }
    end
  end
end
