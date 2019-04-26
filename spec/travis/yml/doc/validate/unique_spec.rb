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
              type: :string
            },
            email: {
              type: :string
            }
          },
          unique: [
            :name,
            :email
          ]
        }
      }
    end

    describe 'given multiple dupes on one key' do
      let(:value) { [{ name: 'one' }, { name: 'one' }, { name: 'two' }, { name: 'two' }] }
      it { should serialize_to value }
      it { should have_msg [:info, :root, :duplicate, name: ['one', 'two']] }
    end

    describe 'given dupes on multiple keys' do
      let(:value) { [{ name: 'one' }, { name: 'one' }, { email: 'str' }, { email: 'str' }] }
      it { should serialize_to value }
      it { should have_msg [:info, :root, :duplicate, name: ['one'], email: ['str']] }
    end
  end
end
