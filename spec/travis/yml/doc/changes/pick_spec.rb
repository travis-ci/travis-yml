describe Travis::Yml::Doc::Change::Pick do
  subject { described_class.new(build_schema(schema), build_value(value)).apply }

  describe 'a str' do
    let(:schema) { { type: :string } }

    describe 'given a str' do
      let(:value) { 'foo' }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a seq of strs' do
      let(:value) { ['foo', 'bar'] }
      it { should serialize_to 'foo' }
      it { should have_msg [:warn, :root, :invalid_seq, value: 'foo'] }
    end

    describe 'given a seq of nums' do
      let(:value) { [1, 2] }
      it { should serialize_to 1 }
      it { should have_msg [:warn, :root, :invalid_seq, value: 1] }
    end

    describe 'given a seq of seqs' do
      let(:value) { [[1], [2]] }
      it { should serialize_to [1] }
      it { should have_msg [:warn, :root, :invalid_seq, value: [1]] }
    end
  end

  describe 'a seq of strs' do
    let(:schema) { { type: :array, items: { type: :string } } }

    describe 'given a nested seq of strs' do
      let(:value) { [['foo', 'bar']] }
      it { should serialize_to ['foo', 'bar'] }
      it { should have_msg [:warn, :root, :invalid_seq, value: ['foo', 'bar']] }
    end
  end
end
