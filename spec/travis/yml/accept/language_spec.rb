describe Travis::Yml, 'language' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'defaults to ruby', required: true, defaults: true do
    yaml ''
    it { should serialize_to language: 'ruby', os: ['linux'] }
    it { should have_msg [:info, :language, :default, default: 'ruby'] }
  end

  Travis::Yml::Schema::Def::Lang.registry.keys.each do |language|
    describe 'known' do
      yaml %(
        language: #{language}
      )
      xit { should serialize_to language: language.to_s }
    end
  end

  describe 'downcases' do
    yaml %(
      language: RUBY
    )
    it { should serialize_to language: 'ruby' }
  end

  describe 'unknown value', v2: true, defaults: true do
    yaml %(
      language: sql
    )
    it { should serialize_to language: 'ruby' }
    it { should have_msg [:warn, :language, :unknown_default, value: 'sql', default: 'ruby'] }
  end

  describe 'given a seq' do
    yaml %(
      language:
      - ruby
    )
    it { should serialize_to language: 'ruby' }
    it { should have_msg [:warn, :language, :invalid_seq, value: 'ruby'] }
  end

  describe 'given a seq with an uppercased value' do
    yaml %(
      language:
      - C
    )
    it { should serialize_to language: 'c' }
  end

  describe 'given a map', required: true, defaults: true do
    yaml %(
      language:
        php: hhvm
    )
    it { should serialize_to defaults }
    it { should have_msg [:error, :language, :invalid_type, expected: :enum, actual: :map, value: { php: 'hhvm' }] }
    it { should have_msg [:info, :language, :default, default: 'ruby'] }
  end

  describe 'given an alias' do
    yaml %(
      language: jvm
    )
    it { should serialize_to language: 'java' }
    it { should have_msg [:info, :language, :alias, alias: 'jvm', value: 'java'] }
  end

  describe 'given a seq' do
    yaml %(
      language:
      - ruby
    )
    it { should serialize_to language: 'ruby' }
    it { should have_msg [:warn, :language, :invalid_seq, value: 'ruby'] }
  end

  describe 'known value with extra special chars' do
    yaml %(
      language:
      - ruby!
    )
    it { should serialize_to language: 'ruby' }
    it { should have_msg [:warn, :language, :find_value, original: 'ruby!', value: 'ruby'] }
  end

  describe 'uppercased alias with non-word chars' do
    yaml %(
      language: C++
    )
    let(:input) { { language: 'C++' } }
    it { should serialize_to language: 'cpp' }
  end

  describe 'given a seq with an uppercased alias with non-word chars' do
    yaml %(
      language:
      - C++
      - java
    )
    it { should serialize_to language: 'cpp' }
  end

  describe 'supports stack names as interim measure' do
    yaml %(
      language: __connie__
    )
    it { should serialize_to language: '__connie__' }
    it { should have_msg [:warn, :language, :deprecated, deprecation: :deprecated_value, value: '__connie__']  }
  end
end
