describe Travis::Yml::Schema::Json::Seq do
  let(:node) { Travis::Yml::Schema::Dsl::Seq.new(nil, opts) }

  subject { described_class.new(node.node) }

  describe 'given :str' do
    let(:opts) { { type: :str } }

    it do
      should have_schema(
        type: :array,
        items: {
          type: :string
        }
      )
    end
  end

  describe 'given multiple types' do
    let(:opts) { { type: [:str, :bool] } }

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
