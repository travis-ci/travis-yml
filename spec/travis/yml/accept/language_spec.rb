describe Travis::Yml, 'language' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'defaults to ruby', defaults: true do
    yaml ''
    it { should serialize_to defaults }
    it { should have_msg [:info, :root, :default, key: 'language', default: 'ruby'] }
  end

  describe 'defaults to objective-c on osx', defaults: true do
    yaml 'os: osx'
    it { should serialize_to language: 'objective-c', os: ['osx'] }
    it { should have_msg [:info, :root, :default, key: 'language', default: 'objective-c'] }
  end

  describe 'defaults to objective-c on linux and osx', defaults: true do
    yaml %(
      os:
      - linux
      - osx
    )
    it { should serialize_to language: 'ruby', os: ['linux', 'osx'], dist: 'xenial' }
    it { should have_msg [:info, :root, :default, key: 'language', default: 'ruby'] }
  end

  langs = Travis::Yml::Schema::Type::Lang.registry
  langs = langs.select { |key, const| const < Travis::Yml::Schema::Type::Lang }
  langs.each do |language, const|
    describe 'known' do
      yaml %(
        language: #{language}
      )
      it { should serialize_to language: language.to_s }
    end
  end

  describe 'downcases' do
    yaml %(
      language: RUBY
    )
    it { should serialize_to language: 'ruby' }
  end

  describe 'unknown value', defaults: true do
    yaml %(
      language: sql
    )
    it { should serialize_to defaults }
    it { should have_msg [:warn, :language, :unknown_default, value: 'sql', default: 'ruby'] }
  end

  describe 'given a seq' do
    yaml %(
      language:
      - ruby
    )
    it { should serialize_to language: 'ruby' }
    it { should have_msg [:warn, :language, :unexpected_seq, value: 'ruby'] }
  end

  describe 'given a seq with an uppercased value' do
    yaml %(
      language:
      - C
    )
    it { should serialize_to language: 'c' }
  end

  describe 'given a seq with an unknown value' do
    yaml %(
      language:
      - none
    )
    it { should serialize_to language: 'ruby' }
    it { should have_msg [:warn, :language, :unexpected_seq, value: 'none'] }
    it { should have_msg [:warn, :language, :unknown_default, value: 'none', default: 'ruby'] }
  end

  describe 'given a map', defaults: true, drop: true do
    yaml %(
      language:
        php: hhvm
    )
    it { should serialize_to defaults }
    it { should have_msg [:error, :language, :invalid_type, expected: :str, actual: :map, value: { php: 'hhvm' }] }
    it { should have_msg [:info, :root, :default, key: 'language', default: 'ruby'] }
  end

  describe 'given an alias' do
    yaml %(
      language: jvm
    )
    it { should serialize_to language: 'java' }
    it { should have_msg [:info, :language, :alias_value, alias: 'jvm', value: 'java'] }
  end

  describe 'given a seq' do
    yaml %(
      language:
      - ruby
    )
    it { should serialize_to language: 'ruby' }
    it { should have_msg [:warn, :language, :unexpected_seq, value: 'ruby'] }
  end

  describe 'known value with extra special chars' do
    yaml %(
      language:
      - ruby!
    )
    it { should serialize_to language: 'ruby' }
    it { should have_msg [:warn, :language, :find_value, original: 'ruby!', value: 'ruby'] }
  end

  describe 'unknown value, with an unsupported key' do
    yaml %(
      language: node_js - 9
      compiler: gcc
    )
    it { should serialize_to language: 'node_js', compiler: ['gcc'] }
    it { should have_msg [:warn, :language, :clean_value, original: 'node_js - 9', value: 'node_js'] }
    it { should have_msg [:warn, :compiler, :unsupported, on_key: 'language', on_value: 'node_js', key: 'compiler', value: ['gcc']] }
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
    it { should have_msg [:warn, :language, :deprecated_value, value: '__connie__', info: 'experimental stack language']  }
  end
end
