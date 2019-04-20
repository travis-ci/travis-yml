require 'travis/yml/helper/obj'

describe Travis::Yml::Helper::Obj do
  include Travis::Yml::Helper::Obj

  describe :str? do
    it { expect(str?('str')).to be true }
    it { expect(str?(1)).to     be false }
    it { expect(str?(true)).to  be false }
  end

  describe :bool? do
    it { expect(bool?('str')).to be false }
    it { expect(bool?(1)).to     be false }
    it { expect(bool?(true)).to  be true }
  end

  describe :true? do
    it { expect(true?('str')).to be false }
    it { expect(true?(true)).to  be true }
    it { expect(true?(false)).to be false }
  end

  describe :false? do
    it { expect(false?('str')).to be false }
    it { expect(false?(true)).to  be false }
    it { expect(false?(false)).to be true }
  end

  describe :present? do
    it { expect(present?('str')).to   be true }
    it { expect(present?(true)).to    be true }
    it { expect(present?(1)).to       be true }
    it { expect(present?([1])).to     be true }
    it { expect(present?({ a: 1})).to be true }
    it { expect(present?('')).to      be false }
    it { expect(present?(false)).to   be false }
    it { expect(present?([])).to      be false }
    it { expect(present?({})).to      be false }
    it { expect(present?(nil)).to     be false }
  end

  describe :to_strs do
    describe 'by default' do
      subject { to_strs(foo: { bar: { baz: :buz }, bam: :bam, bum: true, bem: 1 }) }
      it { should eq foo: { bar: { baz: ['buz'] }, bam: ['bam'], bum: true, bem: 1 } }
    end

    describe 'given types' do
      subject { to_strs({ foo: { bar: { baz: :buz }, bam: :bam, bum: true, bem: 1 } }, Object) }
      it { should eq foo: { bar: { baz: ['buz'] }, bam: ['bam'], bum: ['true'], bem: ['1'] } }
    end
  end

  describe :to_syms do
    let(:obj) { { foo: { bar: { baz: 'buz' }, bam: :bam, bum: true, bem: 1 } } }

    describe 'by default' do
      subject { to_syms(obj) }
      it { should eq foo: { bar: { baz: [:buz] }, bam: [:bam], bum: true, bem: 1 } }
    end

    describe 'given types' do
      subject { to_syms(obj, Object) }
      it { should eq foo: { bar: { baz: [:buz] }, bam: [:bam], bum: [:true], bem: [:'1'] } }
    end
  end

  describe :symbolize do
    subject { symbolize('foo' => ['bar' => 'baz']) }
    it { should eq foo: [bar: 'baz'] }
  end

  describe :compact do
    subject { compact(foo: nil, bar: { baz: { bam: {} }, buz: [nil] }) }
    it { should be_empty }
  end

  describe :only do
    subject { only({ foo: 1, bar: 2, baz: 3 }, :foo, :bar) }
    it { should eq foo: 1, bar: 2 }
  end

  describe :except do
    subject { except({ foo: 1, bar: 2, baz: 3 }, :foo, :bar) }
    it { should eq baz: 3 }
  end

  describe :merge do
    subject do
      merge(
        { foo: { bar: { baz: [1, 2] } } },
        { foo: { bar: { baz: [2, 3, 4] } }, bam: :bum },
      )
    end
    it { should eq foo: { bar: { baz: [1, 2, 3, 4] } }, bam: :bum }
  end

  describe :titleize do
    it { expect(titleize('foo_bar')).to eq 'Foo Bar' }
  end
end
