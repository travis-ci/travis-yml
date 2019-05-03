describe Travis::Yml::Parts::Merge do
  let(:api) do
    <<~yaml
      script: ./api
      env:
        api: true
        foo: 1
    yaml
  end

  let(:travis_yml) do
    <<~yaml
      script: ./travis_yml
      env:
        travis_yml: true
        foo: 2
    yaml
  end

  let(:import) do
    <<~yaml
      script: ./import
      env:
        foo: 3
        import: true
    yaml
  end

  subject { described_class.new(parts).apply }

  let(:parts) do
    [
      Travis::Yml::Parts::Part.new(api, 'api.yml', nil),
      Travis::Yml::Parts::Part.new(travis_yml, '.travis.yml', mode),
      Travis::Yml::Parts::Part.new(import, 'import.yml', mode)
    ]
  end

  describe 'merge' do
    let(:mode) { :merge }
    it { should eq 'script' => './api', 'env' => { 'api' => true, 'foo' => 1 }  }
  end

  describe 'deep_merge' do
    let(:mode) { :deep_merge }
    it { should eq 'script' => './api', 'env' => { 'foo' => 1, 'import' => true, 'travis_yml' => true, 'api' => true }  }
    it { expect(subject['env'].to_a).to eq [['foo', 1], ['import', true], ['travis_yml', true], ['api', true]] }
  end

  describe 'src and line' do
    let(:merged) { described_class.new(parts).apply }
    let(:mode) { :deep_merge }

    describe 'script' do
      subject { merged.keys[0] }

      it { should be_a Key }
      it { should eq 'script' }
      xit { should have_attributes src: 'api', line: 0 }
    end

    describe 'env' do
      subject { merged.keys[1] }

      it { should be_a Key }
      it { should eq 'env' }
      it { should have_attributes src: 'api.yml', line: 1 }
    end

    describe 'foo' do
      subject { merged['env'].keys[0] }

      it { should be_a Key }
      it { should eq 'foo' }
      it { should have_attributes src: 'api.yml', line: 3 }
    end

    describe 'import' do
      subject { merged['env'].keys[1] }

      it { should be_a Key }
      it { should eq 'import' }
      it { should have_attributes src: 'import.yml', line: 3 }
    end

    describe 'travis_yml' do
      subject { merged['env'].keys[2] }

      it { should be_a Key }
      it { should eq 'travis_yml' }
      it { should have_attributes src: '.travis.yml', line: 2 }
    end

    describe 'api' do
      subject { merged['env'].keys[3] }

      it { should be_a Key }
      it { should eq 'api' }
      it { should have_attributes src: 'api.yml', line: 2 }
    end
  end

  def key(key, src)
    Key.new(key).tap { |key| key.src = src }
  end

  describe 'merge' do
    let(:lft) { { foo: 'one', bar: 'one' } }
    let(:rgt) { { baz: 'two', foo: 'two' } }

    subject { described_class.new.send(:merge, lft, rgt) }

    it { should eq foo: 'two', bar: 'one', baz: 'two' }
  end

  describe 'deep_merge (1)' do
    let(:lft) { { foo: { foo: 'one', bar: 'one' }, bar: 'one' } }
    let(:rgt) { { baz: 'two', foo: { bar: 'two', foo: 'two' } } }

    subject { described_class.new.send(:deep_merge, lft, rgt) }

    it { should eq foo: { foo: 'two', bar: 'two' }, bar: 'one', baz: 'two' }
  end

  describe 'deep_merge (2)' do
    let(:lft) { { foo: { foo: 'one', bar: nil }, bar: 'one' } }
    let(:rgt) { { bar: nil, foo: { bar: 'two', foo: nil } } }

    subject { described_class.new.send(:deep_merge, lft, rgt) }

    it { should eq foo: { foo: nil, bar: 'two' }, bar: nil }
  end

  describe 'merge and src' do
    let(:lft) { { key('foo', 'one') => 'one' } }
    let(:rgt) { { key('foo', 'two') => 'two' } }

    subject { described_class.new.send(:merge, lft, rgt) }

    it { should eq 'foo' => 'two' }
    it { expect(subject.keys[0]).to eq 'foo' }
    it { expect(subject.keys[0].src).to eq 'two' }
  end

  describe 'deep_merge and src' do
    let(:lft) { { key('foo', 'one') => 'one' } }
    let(:rgt) { { key('foo', 'two') => 'two' } }

    subject { described_class.new.send(:deep_merge, lft, rgt) }

    it { should eq 'foo' => 'two' }
    it { expect(subject.keys[0]).to eq 'foo' }
    it { expect(subject.keys[0].src).to eq 'two' }
  end
end
