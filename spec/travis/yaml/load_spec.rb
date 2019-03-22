describe Travis::Yaml::Load do
  subject { described_class.apply(parts) }

  describe 'given a single string' do
    let(:parts) { 'foo: bar' }
    it { should eq 'foo' => 'bar' }
  end

  describe 'given an array of strings' do
    let(:parts) { ["foo:\n bar: baz", "foo:\n baz: buz"] }
    it { should eq 'foo' => { 'bar' => 'baz' } }
  end

  describe 'given an array of Parts' do
    let(:one) { Travis::Yaml::Part.new("foo:\n bar: baz\n bam: bam", 'one.yml', :merge) }
    let(:two) { Travis::Yaml::Part.new("foo:\n baz: buz\n bam: bum", 'two.yml', mode) }
    let(:parts) { [one, two] }

    describe 'merge' do
      let(:mode) { :merge }
      it { should eq 'foo' => { 'bar' => 'baz', 'bam' => 'bam' } }
    end

    describe 'deep_merge' do
      let(:mode) { :deep_merge }
      it { should eq 'foo' => { 'bar' => 'baz', 'baz' => 'buz', 'bam' => 'bum' } }
    end
  end
end
