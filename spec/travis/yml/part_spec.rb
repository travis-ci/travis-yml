describe Travis::Yml do
  let(:src) { 'src' }
  let(:merge_mode) { nil }

  subject { const.new(obj, src, merge_mode) }

  shared_examples_for 'shared' do
    describe 'matches the given object' do
      it { should eq obj }
    end

    describe 'has the src' do
      it { expect(subject.src).to eq src }
    end
  end

  shared_examples_for 'base class methods' do |method, *args|
    describe 'base class methods' do
      describe 'retain src' do
        it { expect(subject.send(method, *args).src).to eq src }
      end

      describe 'retain merge_mode' do
        let(:merge_mode) { :replace }
        it { expect(subject.send(method, *args).merge_mode).to eq merge_mode }
      end
    end
  end

  shared_examples_for 'merge_mode' do
    describe 'merge mode defaults to :merge' do
      let(:merge_mode) { nil }
      it { expect(subject.merge_mode).to eq :merge }
    end

    describe 'given a symbol' do
      let(:merge_mode) { :replace }
      it { expect(subject.merge_mode).to eq :replace }
    end

    describe 'given a string' do
      let(:merge_mode) { 'replace' }
      it { expect(subject.merge_mode).to eq :replace }
    end

    describe 'given an unknown mode' do
      let(:merge_mode) { 'unknown' }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe 'Part' do
    let(:const) { described_class::Part }
    let(:obj) { 'foo: bar' }

    include_examples 'shared'
    include_examples 'merge_mode'
    include_examples 'base class methods', :strip
  end

  describe 'Config' do
    let(:const) { described_class::Config }
    let(:obj) { { 'foo' => 'bar' } }
    include_examples 'shared'
    include_examples 'merge_mode'
    include_examples 'base class methods', :merge, {}
  end
end
