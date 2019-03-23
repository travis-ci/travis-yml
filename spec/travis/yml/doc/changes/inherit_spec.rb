describe Travis::Yml::Doc::Change::Inherit do
  let(:change) { described_class.new(build_schema(schema), build_value(value)) }

  subject { change.apply }

  let(:schema) do
    {
      type: :object,
      properties: {
        foo: {
          type: :object,
          properties: {
            bar: {
              type: :string
            }
          },
        },
        on_success: {
          type: :string,
          enum: [
            :always
          ]
        },
        on_failure: {
          type: :string,
          enum: [
            :always
          ]
        }
      },
      changes: [
        change: :inherit,
        keys: [
          :on_success,
          :on_failure
        ]
      ]
    }
  end

  describe 'given a map, and on_success: :always on the parent' do
    let(:value) { { foo: { bar: 'str' }, on_success: 'always' } }
    it { should serialize_to foo: { bar: 'str', on_success: 'always' } }
  end

  describe 'given a map, and on_failure: :always on the parent' do
    let(:value) { { foo: { bar: 'str' }, on_failure: 'always' } }
    it { should serialize_to foo: { bar: 'str', on_failure: 'always' } }
  end

  describe 'given on_success on both the child and parent (does not overwrite)' do
    let(:value) { { foo: { bar: 'str', on_success: 'always' }, on_success: 'never' } }
    it { should serialize_to foo: { bar: 'str', on_success: 'always' } }
  end
end
