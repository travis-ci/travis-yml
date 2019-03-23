describe Travis::Yml::Schema::Json::Map do
  let(:node) { Travis::Yml::Schema::Dsl::Map.new(nil, opts) }
  let(:opts) { {} }

  subject { described_class.new(node.node) }

  it { should_not have_definitions }

  describe 'max_size' do
    let(:opts) { { max_size: 1 } }

    it do
      should have_schema(
        type: :object,
        additionalProperties: false,
        maxProperties: 1
      )
    end
  end

  describe 'prefix (transforms to anyOf)' do
    let(:opts) { { prefix: :foo } }

    before { node.map :foo, to: :str }

    it do
      should have_schema(
        anyOf: [
          {
            type: :object,
            additionalProperties: false,
            properties: {
              foo: {
                type: :string
              }
            },
            prefix: :foo,
            normal: true
          },
          {
            type: :string
          }
        ]
      )
    end
  end

  describe 'strict' do
    describe 'default' do
      it do
        should have_schema(
          type: :object,
          additionalProperties: false
        )
      end
    end

    describe 'strict (given true)' do
      let(:opts) { { strict: true } }

      it do
        should have_schema(
          type: :object,
          additionalProperties: false
        )
      end
    end

    describe 'strict (given false)' do
      let(:opts) { { strict: false } }

      it do
        should have_schema(
          type: :object,
        )
      end
    end
  end

  describe 'required' do
    before { node.map :foo, to: :str, required: true }

    it do
      should have_schema(
        type: :object,
        additionalProperties: false,
        properties: {
          foo: {
            type: :string
          }
        },
        required: [:foo]
      )
    end
  end

  describe 'unique' do
    before { node.map :foo, to: :str, unique: true }

    it do
      should have_schema(
        type: :object,
        additionalProperties: false,
        properties: {
          foo: {
            type: :string
          }
        },
        unique: [:foo]
      )
    end
  end

  describe 'with an include (transforms to allOf)' do
  end
end
