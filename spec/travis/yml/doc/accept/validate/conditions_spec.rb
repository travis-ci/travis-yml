describe Travis::Yml, 'conditions' do
  subject { described_class.apply(value) }

  describe 'if' do
    describe 'given a valid condition' do
      let(:value) { { if: 'tag = v1.0.0' } }
      it { should_not have_msg }
      it { should serialize_to value }
    end

    describe 'given an invalid condition' do
      let(:value) { { if: 'and true' } }
      it { should have_msg [:error, :if, :invalid_condition, condition: 'and true'] }
      it { should serialize_to({}) }
    end
  end
end
