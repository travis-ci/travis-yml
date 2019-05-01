describe Travis::Yml::Schema::Json::Str do
  let(:node) { Travis::Yml::Schema::Dsl::Str.new(nil, opts) }
  let(:opts) { {} }

  subject { described_class.new(node.node) }

  it { should have_schema type: :string }

  describe 'downcase' do
    let(:opts) { { downcase: true } }
    it { should have_schema type: :string, downcase: true }
  end

  describe 'format' do
    let(:opts) { { format: '.*' } }
    it { should have_schema type: :string, pattern: '.*' }
  end

  describe 'vars' do
    let(:opts) { { vars: ['str'] } }
    it { should have_schema type: :string, vars: ['str'] }
  end
end
