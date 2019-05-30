describe Travis::Yml::Schema::Json::Seq do
  def const(define)
    Class.new(Travis::Yml::Schema::Type::Seq) do
      define_method(:define, &define)
    end
  end

  subject { const(define).new }

  describe 'given :str' do
    let(:define) { -> { types :str, edge: true } }

    it do
      should have_schema(
        type: :array,
        items: {
          type: :string,
          flags: [:edge]
        }
      )
    end
  end

  describe 'given multiple types' do
    let(:define) { -> { types :str, :bool } }

    it do
      should have_schema(
        type: :array,
        items: {
          anyOf: [
            {
              type: :string,
            },
            {
              type: :boolean
            }
          ]
        }
      )
    end
  end
end
