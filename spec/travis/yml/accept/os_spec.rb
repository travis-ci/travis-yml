describe Travis::Yml, 'os' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'defaults to linux', defaults: true do
    yaml ''
    it { should serialize_to defaults }
    it { should have_msg [:info, :os, :default, key: 'os', default: 'linux'] }
  end

  describe 'given a string' do
    known = %w(
      linux
      osx
      windows
    )

    known.each do |value|
      describe "given #{value}" do
        yaml %(
          os: #{value}
        )
        it { should serialize_to os: [value] }
        it { should_not have_msg }
      end
    end

    describe 'an alias' do
      yaml %(
        os: ubuntu
      )
      it { should serialize_to os: ['linux'] }
    end

    describe 'downcases' do
      yaml %(
        os: LINUX
      )
      it { should serialize_to os: ['linux'] }
    end

    describe 'unknown', defaults: true do
      yaml %(
        os: unknown
      )
      it { should serialize_to language: 'ruby', os: ['linux'] }
      it { should have_msg [:warn, :os, :unknown_default, value: 'unknown', default: 'linux'] }
    end
  end

  describe 'given a seq' do
    describe 'known' do
      yaml %(
        os:
        - linux
        - osx
      )
      it { should serialize_to os: ['linux', 'osx'] }
    end

    describe 'aliases' do
      yaml %(
        os:
        - ubuntu
        - macos
      )
      it { should serialize_to os: ['linux', 'osx'] }
    end

    describe 'downcases' do
      yaml %(
        os:
          - LINUX
          - OSX
      )
      it { should serialize_to os: ['linux', 'osx'] }
    end
  end

  describe 'given a mixed, nested seq' do
    yaml %(
      os:
      - linux
      - os: osx
    )
    let(:value) { { os: ['linux', os: 'osx'] } }
    it { should serialize_to os: ['linux'] }
    it { should have_msg [:error, :os, :invalid_type, expected: :str, actual: :map, value: { os: 'osx' }] }
  end

  describe 'defaults to osx for objective-c', defaults: true do
    yaml %(
      language: objective-c
    )
    it { should serialize_to language: 'objective-c', os: ['osx'] }
    it { should have_msg [:info, :os, :default, key: 'os', default: 'osx'] }
  end

  describe 'an os unsupported by the language' do
    yaml %(
      os: osx
      language: php
    )
    it { should serialize_to os: ['osx'], language: 'php' }
    it { should have_msg [:warn, :os, :unsupported, on_key: 'language', on_value: 'php', key: 'os', value: 'osx'] }
  end

  describe 'complains about jdk on osx' do
    yaml %(
      os: osx
      language: java
      jdk: default
    )
    it { should serialize_to os: ['osx'], language: 'java', jdk: ['default'] }
    it { should have_msg [:warn, :jdk, :unsupported, on_key: 'os', on_value: 'osx', key: 'jdk', value: ['default']] }
  end

  describe 'given a mixed, nested seq, with an unsupported key on root' do
    yaml %(
      os:
      - linux
      - os: osx
      osx_image: str
    )
    it { should serialize_to os: ['linux'], osx_image: 'str' }
    it { should have_msg [:error, :os, :invalid_type, expected: :str, actual: :map, value: { os: 'osx' }] }
    it { should have_msg [:warn, :osx_image, :unsupported, on_key: 'os', on_value: 'linux', key: 'osx_image', value: 'str'] }
  end
end
