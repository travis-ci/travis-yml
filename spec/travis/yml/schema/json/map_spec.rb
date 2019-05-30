describe Travis::Yml::Schema::Json::Map do
  def const(define)
    Class.new(Travis::Yml::Schema::Type::Map) do
      define_method(:define, &define)
    end
  end

  subject { const(define).new }

  describe 'max_size' do
    let(:define) { -> { max_size 1 } }

    it do
      should have_schema(
        type: :object,
        maxProperties: 1
      )
    end
  end

  describe 'strict' do
    describe 'default' do
      let(:define) { -> {} }

      it do
        should have_schema(
          type: :object,
        )
      end
    end

    describe 'strict (given true)' do
      let(:define) { -> { strict true } }

      it do
        should have_schema(
          type: :object,
          additionalProperties: false
        )
      end
    end

    describe 'strict (given false)' do
      let(:define) { -> { strict false } }

      it do
        should have_schema(
          type: :object,
        )
      end
    end
  end

  describe 'required' do
    let(:define) { -> { map :foo, to: :str, required: true } }

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
    let(:define) { -> { map :foo, to: :str, unique: true } }

    it do
      should have_schema(
        type: :object,
        additionalProperties: false,
        properties: {
          foo: {
            type: :string,
            flags: [
              :unique
            ]
          }
        },
      )
    end
  end

  describe 'given a type' do
    let(:define) { -> { types :str } }

    it do
      should have_schema(
        type: :object,
        patternProperties: {
          '.*': {
            type: :string
          }
        }
      )
    end
  end

  describe 'given types' do
    let(:define) { -> { types :map, :secure } }

    it do
      should have_schema(
        type: :object,
        patternProperties: {
          '.*': {
            anyOf: [
              {
                type: :object
              },
              {
                '$ref': '#/definitions/type/secure',
              },
            ]
          }
        }
      )
    end
  end
end
