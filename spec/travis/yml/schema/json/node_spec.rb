describe Travis::Yml::Schema::Json::Str do
  let(:node) { Travis::Yml::Schema::Dsl::Str.new(nil, opts) }
  let(:opts) { {} }

  subject { described_class.new(node.node) }

  describe 'edge' do
    let(:opts) { { edge: true } }
    it { should have_schema type: :string, flags: [:edge] }
  end
end
