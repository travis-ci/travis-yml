describe Travis::Yml, 'invalid_type', line: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'language' do
    describe 'given a str' do
      yaml 'language: ruby'
      it { should serialize_to language: 'ruby' }
      it { should_not have_msg }
    end

    describe 'given a num' do
      yaml 'language: 1'
      it { should serialize_to language: 'ruby' }
      it { should have_msg [:warn, :language, :unknown_default, value: '1', default: 'ruby', line: 0] }
    end
  end

  describe 'git.depth' do
    describe 'given a num' do
      yaml 'git: { depth: 1 }'
      it { should serialize_to git: { depth: 1 } }
      it { should_not have_msg }
    end

    describe 'given a bool' do
      yaml 'git: { depth: true }'
      it { should serialize_to git: { depth: true } }
      it { should_not have_msg } # hmmm.
    end

    describe 'given a str' do
      yaml 'git: { depth: str }'
      it { should serialize_to git: { depth: 'str' } }
      it { should have_msg [:error, :'git.depth', :invalid_type, expected: :num, actual: :str, value: 'str', line: 0] }
    end
  end

  describe 'cache.bundler' do
    describe 'given a bool' do
      yaml 'cache: { bundler: true }'
      it { should serialize_to cache: { bundler: true } }
      it { should_not have_msg }
    end

    describe 'given the str "true"' do
      yaml 'cache: { bundler: "true" }'
      it { should serialize_to cache: { bundler: true } }
      it { should_not have_msg }
    end

    describe 'given any str' do
      yaml 'cache: { bundler: str }'
      xit { should serialize_to cache: { bundler: true } }
      xit { should_not have_msg }
    end
  end

  describe 'os' do
    describe 'given a seq' do
      yaml 'os: [linux, osx]'
      it { should serialize_to os: ['linux', 'osx'] }
      it { should_not have_msg }
    end

    describe 'given a map' do
      yaml 'os: { name: linux }'

      describe 'drop turned off (default)' do
        it { should serialize_to os: [name: 'linux'] }
        it { should have_msg [:error, :os, :invalid_type, expected: :str, actual: :map, value: { name: 'linux' }, line: 0] }
      end

      describe 'drop turned on', drop: true do
        it { should serialize_to empty }
        it { should have_msg [:error, :os, :invalid_type, expected: :str, actual: :map, value: { name: 'linux' }, line: 0] }
      end
    end
  end

  describe 'git' do
    describe 'given a map' do
      yaml 'git: { strategy: clone }'
      it { should serialize_to git: { strategy: 'clone' } }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml 'git: str'

      describe 'drop turned off (default)' do
        it { should serialize_to git: 'str' }
        it { should have_msg [:error, :git, :invalid_type, expected: :map, actual: :str, value: 'str', line: 0] }
      end

      describe 'drop turned on', drop: true do
        it { should serialize_to empty }
        it { should have_msg [:error, :git, :invalid_type, expected: :map, actual: :str, value: 'str', line: 0] }
      end
    end
  end
end
