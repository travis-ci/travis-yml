describe Travis::Yml::Doc, 'build' do
  let(:schema) do
    {
      title: 'title',
      '$schema': 'schema',
      type: :object,
      properties: {
        foo: {
          type: :string
        }
      },
      additionalProperties: false
    }
  end

  subject { build_schema(schema) }

  it { expect(subject['foo']).to be_str }
  it { expect(subject.strict?).to be true }
end
