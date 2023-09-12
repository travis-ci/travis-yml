describe Yaml do
  subject { described_class.load(yaml) }

  describe 'empty string' do
    yaml ''
    it { should be false }
  end

  describe 'string with whitespace' do
    yaml '   '
    it { should be false }
  end

  describe 'newline' do
    yaml "\n"
    it { should be false }
  end

  describe '~' do
    yaml '~'
    it { should be nil }
  end

  describe 'true' do
    yaml 'true'
    it { should be true }
  end

  describe 'false' do
    yaml 'false'
    it { should be false }
  end

  describe 'yes' do
    yaml 'yes'
    it { should eq 'yes' }
  end

  describe 'no' do
    yaml 'no'
    it { should eq 'no' }
  end

  describe 'on' do
    yaml 'on'
    it { should eq 'on' }
  end

  describe 'off' do
    yaml 'off'
    it { should eq 'off' }
  end

  describe 'string' do
    yaml 'str'
    it { should eq 'str' }
  end

  describe 'timestamp' do
    yaml '2020-01-01 00:00:00 -0000'
    it { should eq '2020-01-01 00:00:00 -0000' }
  end

  describe 'symbol' do
    yaml ':sym'
    it { should eq 'sym' }
  end

  describe 'integer' do
    yaml '1'
    it { should eq 1 }
  end

  describe 'float' do
    yaml '1.10'
    it { should eq '1.10' }
  end

  describe 'sequence' do
    yaml '- str'
    it { should eq ['str'] }
  end

  describe 'map with a key str' do
    yaml 'str: str'
    it { should eq 'str' => 'str' }
  end

  describe 'map with a key :sym' do
    yaml ':sym: str'
    it { should eq 'sym' => 'str' }
  end

  describe 'map with a key true' do
    yaml 'true: str'
    it { should eq 'true' => 'str' }
  end

  describe 'map with a key on' do
    yaml 'on: str'
    it { should eq 'on' => 'str' }
  end

  describe 'map with a key 1' do
    yaml '1: str'
    it { should eq '1' => 'str' }
  end

  describe 'map with a key 1.1' do
    yaml '1.1: str'
    it { should eq '1.1' => 'str' }
  end

  describe 'map with a float' do
    yaml 'str: 1.10'
    it { should eq 'str' => '1.10' }
  end

  describe 'map with a timestamp' do
    yaml 'str: 2020-01-01 00:00:00 -0000'
    it { should eq 'str' => '2020-01-01 00:00:00 -0000' }
  end

  describe 'map with bad indentation' do
    yaml <<~yaml
       one: str
      two: str
    yaml
    it { should eq 'one' => 'str' }
  end

  describe 'strings containing a colon (unquoted)' do
    yaml %(
      foo:
        - bar: baz
    )
    it { should eq 'foo' => ['bar' => 'baz'] }
  end

  describe 'string containing a colon (single quoted)' do
    yaml %(
      foo:
        - 'bar: baz'
    )
    it { should eq 'foo' => ['bar: baz'] }
  end

  describe 'string containing a colon (double quoted)' do
    yaml %(
      foo:
        - "bar: baz"
    )
    it { should eq 'foo' => ['bar: baz'] }
  end

  describe 'a binary' do
    yaml %(
      secure: !!binary |
        T21OL05XaVhRNkpR
    )
    it { should eq 'secure' => 'OmN/NWiXQ6JQ' }
  end

  describe '!ruby/symbol' do
    yaml %(
      --- !ruby/symbol sym
    )
    it { should eq '--- !ruby/symbol sym' }
  end

  describe '!ruby/set' do
    yaml %(
      --- !ruby/set
      - 1
    )
    it { should eq '--- !ruby/set - 1' }
  end

  describe 'map has keys with line numbers' do
    yaml <<~yaml
      foo:
        - bar:
            baz: str
    yaml
    it { should eq 'foo' => ['bar' => { 'baz' => 'str' }] }

    describe 'root' do
      it { should be_a Map }
      it { expect(subject.keys[0]).to eq 'foo' }
      it { expect(subject.keys[0]).to be_a Key }
      it { expect(subject.keys[0].line).to eq 0 }
    end

    describe 'foo' do
      subject { super()['foo'][0] }
      it { should be_a Map }
      it { expect(subject.keys[0]).to eq 'bar' }
      it { expect(subject.keys[0]).to be_a Key }
      it { expect(subject.keys[0].line).to eq 1 }
    end

    describe 'bar' do
      subject { super()['foo'][0]['bar'] }
      it { should be_a Map }
      it { expect(subject.keys[0]).to eq 'baz' }
      it { expect(subject.keys[0]).to be_a Key }
      it { expect(subject.keys[0].line).to eq 2 }
    end
  end

  describe 'anchor keys (map)' do
    yaml %(
      foo: &ref
        one: str
      bar: *ref
    )
    it { should eq 'foo' => { 'one' => 'str' }, 'bar' => { 'one' => 'str' } }
    it { should have_attributes opts: { anchors: ['foo'] } }
  end

  describe 'anchor keys (map)' do
    yaml %(
      foo: &ref
        one: str
      bar:
        <<: *ref
        two: str
    )
    it { should eq 'foo' => { 'one' => 'str' }, 'bar' => { 'one' => 'str', 'two' => 'str' } }
    it { should have_attributes opts: { anchors: ['foo'] } }
  end

  describe 'nested anchor keys (map)' do
    yaml %(
      root: &foo
        foo: &bar
          one: str
      bar:
        <<: *bar
        <<: *foo
    )
    it { should eq 'root' => { 'foo' => { 'one' => 'str' } }, 'bar' => { 'foo' => { 'one' => 'str' },  'one' => 'str' } }
    it { should have_attributes opts: { anchors: ['root', 'foo'] } }
  end

  describe 'anchor keys (seq)' do
    yaml %(
      foo: &ref
        - one
      bar:
        - *ref
    )
    it { should eq 'foo' => ['one'], 'bar' => [['one']] }
    it { should have_attributes opts: { anchors: ['foo'] } }
  end

  describe 'anchor keys (seq)' do
    yaml %(
      foo: &ref
        |-
          str
      bar:
        - *ref
    )
    it { should eq 'foo' => 'str', 'bar' => ['str'] }
    it { should have_attributes opts: { anchors: ['foo'] } }
  end

  describe 'broken anchor (user input, not sure if this is right)' do
    yaml %(
      &a:  5
      b: *a
      c:
       <<: *a
    )

    it { should eq '' => 5, 'b' => '', 'c' => { '<<' => '' } }
  end

  describe 'map with a map as a key' do
    yaml %(
    foo:
      { bar: baz }: buz
    )

    it { expect { subject }.to raise_error Psych::SyntaxError }
  end

  describe 'disallowed classes' do
    describe 'timestamp' do
      yaml %(
        foo: 2020-01-01 00:00:00
      )
      it { should eq 'foo' => '2020-01-01 00:00:00' }
    end

    describe 'Highline::String' do
      yaml %(
        foo: !ruby/string:HighLine::String bar
      )
      it { should eq 'foo' => 'bar' }
    end
  end

  describe 'merge modes (map, 1)' do
    yaml %(
      !deep_merge+append
      foo: bar
    )
    it { should eq 'foo' => 'bar' }
    it { should be_a Map }
    it { should have_attributes opts: { merge_modes: { rgt: :deep_merge_append } } }
  end

  describe 'merge modes (map, 2)' do
    yaml %(
      foo: !deep_merge+append
        bar:
        - baz
    )
    it { should eq 'foo' => { 'bar' => ['baz'] } }
    it { should be_a Map }
    it { expect(subject['foo']).to have_attributes opts: { merge_modes: { rgt: :deep_merge_append } } }
  end

  describe 'merge modes (seq, 1)' do
    yaml %(
      !append
      - one
    )
    it { should eq ['one'] }
    it { should be_a Seq }
    it { should have_attributes merge_modes: { rgt: :append } }
  end

  describe 'merge modes (seq, 2)' do
    yaml %(
      foo: !append
        - one
    )
    it { should eq 'foo' => ['one'] }
    it { expect(subject['foo']).to be_a Seq }
    it { expect(subject['foo']).to have_attributes merge_modes: { rgt: :append } }
  end

  describe 'duplicate keys' do
    yaml %(
      one: one
      one: two
    )
    it { should eq 'one' => 'two' }
    it { should be_a Map }
    it { should have_attributes opts: { warnings: ['Duplicate key one'] } }
  end
end
