describe Travis::Yml, 'conditions', drop: true, line: true do
  subject { Travis::Yml.apply(parse(yaml), opts) }

  describe 'if' do
    describe 'given a valid condition' do
      yaml 'if: tag = v1.0.0'
      it { should serialize_to if: 'tag = v1.0.0' }
      it { should_not have_msg }
    end

    describe 'given an invalid condition' do
      yaml "\nif: and true"
      it { should serialize_to empty }
      it { should have_msg [:error, :if, :invalid_condition, condition: 'and true', line: 1] }
    end
  end
end
