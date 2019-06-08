require 'travis/yml/support/merge'

describe Travis::Yml::Support::Merge do
  let(:lft) do
    parse %(
      # comment
      foo:
        one:
        - two
    )
  end

  let(:rgt) do
    parse %(
      foo:
        one:
        - one
        two: two
      bar: bar
    )
  end

  let(:mode) { nil }

  subject { described_class.new(lft, rgt, mode).apply }

  describe 'replace' do
    let(:mode) { :replace }
    it { should eq 'foo' => { 'one' => ['two'] } }
  end

  describe 'merge' do
    let(:mode) { :merge }
    it { should eq 'foo' => { 'one' => ['two'] }, 'bar' => 'bar' }
    it { expect(subject.keys.first).to be_a Key }
    it { expect(subject.keys.first.line).to eq 2 }
  end

  describe 'deep_merge' do
    let(:mode) { :deep_merge }
    it { should eq 'foo' => { 'one' => ['two'], 'two' => 'two' }, 'bar' => 'bar' }
    it { expect(subject.keys.first).to be_a Key }
    it { expect(subject.keys.first.line).to eq 2 }
  end

  describe 'deep_merge_append' do
    let(:mode) { :deep_merge_append }
    it { should eq 'foo' => { 'one' => ['one', 'two'], 'two' => 'two' }, 'bar' => 'bar' }
    it { expect(subject.keys.first).to be_a Key }
    it { expect(subject.keys.first.line).to eq 2 }
  end

  describe 'merge tags (1)' do
    let(:lft) do
      parse %(
        !map+deep_merge+append
        foo:
          one:
          - two
      )
    end
    it { should eq 'foo' => { 'one' => ['one', 'two'], 'two' => 'two' }, 'bar' => 'bar' }
  end

  describe 'merge tags (2)' do
    let(:mode) { :deep_merge }

    let(:lft) do
      parse %(
        foo:
          !map+deep_merge+append
          one:
          - two
      )
    end

    it { should eq 'foo' => { 'one' => ['one', 'two'], 'two' => 'two' }, 'bar' => 'bar' }
  end

  describe 'merge tags (3)' do
    let(:mode) { :deep_merge }

    let(:lft) do
      parse %(
        foo:
          one: !seq+append
          - two
      )
    end

    it { should eq 'foo' => { 'one' => ['one', 'two'], 'two' => 'two' }, 'bar' => 'bar' }
  end
end
