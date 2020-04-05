describe Travis::Yml::Parts::Part do
  let(:str) { 'foo: bar' }
  let(:src) { 'src' }
  let(:merge_mode) { nil }

  subject { described_class.new(str, src, merge_mode) }

  # describe 'matches the given string' do
  #   it { should eq str }
  # end
  #
  # describe 'has the src' do
  #   it { expect(subject.src).to eq src }
  # end
  #
  # describe 'merge_mode' do
  #   describe 'given a symbol' do
  #     let(:merge_mode) { :replace }
  #     it { expect(subject.merge_mode).to eq :replace }
  #   end
  #
  #   describe 'given a string' do
  #     let(:merge_mode) { 'replace' }
  #     it { expect(subject.merge_mode).to eq :replace }
  #   end
  #
  #   describe 'given an unknown mode' do
  #     let(:merge_mode) { 'unknown' }
  #     it { expect { subject }.to raise_error(ArgumentError) }
  #   end
  # end
end
