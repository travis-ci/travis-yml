describe Travis::Yml::Schema::Dsl::Any do
  let(:dsl) { Class.new(described_class).new }
  let(:schema) { subject.schemas.first }

  subject { dsl.node }

  describe 'detect' do
    before { dsl.detect :provider }
    it { should have_opts detect: :provider }
  end

  describe 'add' do
    before { dsl.add :num }
    it { expect(schema).to be_num }
  end

  describe 'add with opts' do
    before { dsl.add :num, normal: true, edge: true }
    it { expect(schema).to have_opts normal: true, flags: [:edge] }
  end
end
