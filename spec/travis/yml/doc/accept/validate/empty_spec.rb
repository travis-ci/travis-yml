describe Travis::Yml, 'empty', empty: true, line: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'os' do
    describe 'given a seq' do
      yaml 'os: [linux, osx]'
      it { should_not have_msg }
    end

    describe 'given an empty array' do
      yaml 'os: []'
      it { should have_msg [:warn, :os, :empty, key: 'os', line: 0] }
    end

    describe 'given nil' do
      yaml 'os:'
      it { should have_msg [:warn, :os, :empty, key: 'os', line: 0] }
    end
  end

  describe 'cache.bundler' do
    describe 'given a map' do
      yaml 'cache: { bundler: true }'
      it { should_not have_msg }
    end

    describe 'given an empty map' do
      yaml 'cache: {}'
      it { should have_msg [:warn, :cache, :empty, key: 'cache', line: 0] }
    end

    describe 'given nil' do
      yaml 'cache:'
      it { should have_msg [:warn, :cache, :empty, key: 'cache', line: 0] }
    end
  end
end
