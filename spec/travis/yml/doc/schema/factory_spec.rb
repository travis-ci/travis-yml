describe Travis::Yml::Doc::Schema, 'build' do
  subject { described_class.build(schema) }

  matcher :have_schema do |type|
    match { |seq| seq.schema.is?(type) }
  end

  matcher :have_value do |value, opts = {}|
    match { |node| node.values.any? { |obj| obj.value == value && opts.all? { |k, v| obj.opts[k] == v } } }
  end

  describe 'a boolean' do
    let(:schema) { { type: :boolean } }
    it { should be_bool }
  end

  describe 'a number' do
    let(:schema) { { type: :number } }
    it { should be_num }
  end

  describe 'a string' do
    let(:schema) { { type: :string } }
    it { should be_str }
  end

  describe 'an enum' do
    let(:schema) { { type: :string, enum: ['foo', 'bar'], values: { foo: { aliases: ['bar'], edge: true } } } }
    it { should be_enum }
    it { should have_value ['foo', aliases: ['bar'], edge: true] }
    it { should have_value ['bar'] }
  end

  describe 'an object' do
    let(:schema) { { type: :object, properties: { foo: { type: :string } } }.merge(opts) }
    let(:opts) { {} }

    it { should be_map }
    it { expect(subject['foo']).to be_str }

    describe 'by default' do
      let(:opts) { {} }
      it { should_not be_strict }
    end

    describe 'strict' do
      let(:opts) { { additionalProperties: false } }
      it { should be_strict }
    end

    describe 'not strict' do
      let(:opts) { { additionalProperties: true } }
      it { should_not be_strict }
    end

    describe 'patternProperties' do
      let(:opts) { { patternProperties: { '.*': { type: :string } } } }
      it { should_not be_strict }
    end
  end

  describe 'an array of strings' do
    let(:schema) { { type: :array, items: { type: :string } } }
    it { should be_seq }
    it { should have_schema :str }
  end

  describe 'an array of objects' do
    let(:schema) { { type: :array, items: { type: :object, properties: { foo: { type: :string } }, additionalProperties: true } } }
    it { should be_seq }
    it { should have_schema :map }
    it { expect(subject.schema).to_not be_strict }
    it { expect(subject.schema['foo']).to be_str }
  end

  describe 'a secure' do
    let(:schema) do
      {
        '$id': :secure,
        anyOf: [
          {
            type: :object,
            properties: {
              secure: {
                type: :string
              }
            },
            additionalProperties: false,
            maxProperties: 1,
            normal: true
          },
          {
            type: :string,
            normal: true
          }
        ]
      }
    end

    it { should be_secure }
  end

  describe 'a secure (ref)' do
    let(:schema) do
      {
        '$ref': '#/definitions/type/secure'
      }
    end

    it { should be_secure }
  end

  describe 'a oneOf' do
    let(:schema) do
      {
        '$id': :foo,
        oneOf: [
          {
            type: :object,
            properties: {
              foo: {
                type: :string
              }
            },
            additionalProperties: false,
          },
          {
            type: :object,
            properties: {
              bar: {
                type: :boolean
              }
            },
            additionalProperties: false,
          }
        ]
      }
    end

    it { should be_map }
    it { expect(subject.id).to eq :foo }
    it { expect(subject['foo']).to be_str }
    it { expect(subject['bar']).to be_bool }
  end

  # describe 'a oneOf (with refs)' do
  #   let(:schema) do
  #     {
  #       '$id': :foo,
  #       oneOf: [
  #         {
  #           type: :object,
  #           properties: {
  #             foo: {
  #               type: :string
  #             }
  #           },
  #           additionalProperties: false,
  #         },
  #         {
  #           type: :object,
  #           properties: {
  #             bar: {
  #               type: :boolean
  #             }
  #           },
  #           additionalProperties: false,
  #         }
  #       ]
  #     }
  #   end
  #
  #   it { should be_map }
  #   it { expect(subject.id).to eq :foo }
  #   it { expect(subject[:foo]).to be_str }
  #   it { expect(subject[:bar]).to be_bool }
  # end

  describe 'a schema (map)' do
    let(:schema) do
      {
        title: 'title',
        '$schema': 'uri',
        type: :object,
        properties: {
          foo: {
            type: :string
          }
        }
      }
    end

    it { should be_map }
    it { expect(subject['foo']).to be_str }
  end

  describe 'a schema (allOf)' do
    let(:schema) do
      {
        title: 'title',
        '$schema': 'uri',
        allOf: [
          {
            type: :object,
            properties: {
              foo: {
                type: :string
              }
            }
          },
          {
            type: :object,
            properties: {
              bar: {
                type: :boolean
              }
            }
          },
        ]
      }
    end

    it { should be_map }
    it { expect(subject['foo']).to be_str }
    it { expect(subject['bar']).to be_bool }
  end
end
