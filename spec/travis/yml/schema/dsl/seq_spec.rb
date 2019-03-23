describe Travis::Yml::Schema::Dsl::Seq do
  let(:dsl)  { Class.new(described_class).new }

  subject { dsl.node}

  describe 'type' do
    before { dsl.type :num }
    it { expect(subject.schemas.first).to be_num }
  end
end
