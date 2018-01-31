describe Travis::Yaml, 'stack' do
  let(:config) { subject.serialize }
  let(:stack)  { config[:stack] }

  subject { described_class.apply(input) }

  describe 'accepts fixed value with edge message' do
    let(:input) { { stack: 'connie' } }
    specify { expect(stack).to eq 'connie' }
    specify { expect(subject.msgs).to include [:info, :stack, :edge, { given: 'connie' }] }
  end

  describe 'downcases value' do
    let(:input) { { stack: 'Connie' } }
    specify { expect(stack).to eq 'connie' }
  end

  describe 'errors when value is not allowed' do
    let(:input) { { stack: 'superman' } }
    specify { expect(stack).to be_nil }
    specify { expect(subject.msgs).to include [:error, :stack, :unknown_value, { value: 'superman' }] }
  end
end
