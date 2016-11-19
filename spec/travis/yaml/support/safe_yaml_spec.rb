describe SafeYAML do
  subject { described_class.load(input) }

  describe 'loading true' do
    let(:input) { 'true' }
    it { should eq true }
  end

  describe 'loading false' do
    let(:input) { 'false' }
    it { should eq false }
  end

  describe 'loading a string' do
    let(:input) { 'foo' }
    it { should eq 'foo' }
  end

  describe 'loading an integer' do
    let(:input) { '1' }
    it { should eq '1' }
  end

  describe 'loading a float' do
    let(:input) { '1.10' }
    it { should eq '1.10' }
  end

  describe 'loading a sequence with a float' do
    let(:input) { '- 1.10' }
    it { should eq ['1.10'] }
  end

  describe 'loading a map with a float' do
    let(:input) { 'foo: 1.10' }
    it { should eq 'foo' => '1.10' }
  end

  describe 'loading yes' do
    let(:input) { 'yes' }
    it { should eq 'yes' }
  end

  describe 'loading no' do
    let(:input) { 'no' }
    it { should eq 'no' }
  end

  describe 'loading on' do
    let(:input) { 'on' }
    it { should eq 'on' }
  end

  describe 'loading off' do
    let(:input) { 'off' }
    it { should eq 'off' }
  end
end
