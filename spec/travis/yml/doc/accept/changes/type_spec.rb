describe Travis::Yml::Doc::Change do
  subject { described_class.apply(schema, build_value(value, opts)) }

  describe 'addons.code_climate' do
    let(:schema) { Travis::Yml.expand['addons']['code_climate'] }

    describe 'a str' do
      let(:value) { 'foo' }
      it { should serialize_to repo_token: 'foo' }
    end

    describe 'a seq of strs' do
      let(:value) { ['foo'] }
      it { should serialize_to repo_token: 'foo' }
    end

    describe 'a map' do
      let(:value) { { repo_token: 'foo' } }
      it { should serialize_to repo_token: 'foo' }
    end

    describe 'seq of maps' do
      let(:value) { [repo_token: 'foo'] }
      it { should serialize_to repo_token: 'foo' }
    end
  end

  describe 'addons.apt' do
    let(:schema) { Travis::Yml.expand['addons']['apt'] }

    describe 'a str' do
      let(:value) { 'foo' }
      it { should serialize_to packages: ['foo'] }
    end

    describe 'a seq of strs' do
      let(:value) { ['foo'] }
      it { should serialize_to packages: ['foo'] }
    end

    describe 'a seq of maps' do
      let(:value) { [packages: 'foo'] }
      it { should serialize_to packages: ['foo'] }
    end

    describe 'a map with a str on :packages' do
      let(:value) { { packages: 'foo' } }
      it { should serialize_to packages: ['foo'] }
    end

    describe 'a map with a seq of strs on :packages' do
      let(:value) { { packages: ['foo'] } }
      it { should serialize_to packages: ['foo'] }
    end

    describe 'a str on :sources' do
      let(:value) { { sources: 'foo' } }
      it { should serialize_to sources: [name: 'foo'] }
    end

    describe 'a seq of strs on :sources' do
      let(:value) { { sources: ['foo'] } }
      it { should serialize_to sources: [name: 'foo'] }
    end

    describe 'a map with a str on :sources' do
      let(:value) { { sources: { name: 'foo' } } }
      it { should serialize_to sources: [name: 'foo'] }
    end

    describe 'a seq of maps with a str on :sources' do
      let(:value) { { sources: [{ name: 'foo' }, { name: 'bar' }] } }
      it { should serialize_to sources: [{ name: 'foo' }, { name: 'bar' }] }
    end
  end

  describe 'archs' do
    let(:schema) { Travis::Yml.expand['arch'] }

    describe 'a str' do
      let(:value) { 'amd64' }
      it { should serialize_to ['amd64'] }
    end

    describe 'a seq of strs' do
      let(:value) { ['amd64'] }
      it { should serialize_to ['amd64'] }
    end

    describe 'a map with an arch' do
      let(:value) { { name: 'amd64' } }
      it { should serialize_to [name: 'amd64'] }
    end

    describe 'a map with a seq of strs' do
      let(:value) { { name: ['amd64'] } }
      it { should serialize_to [name: ['amd64']] }
    end
  end

  describe 'branches' do
    let(:schema) { Travis::Yml.expand['branches'] }

    describe 'a str' do
      let(:value) { 'foo' }
      it { should serialize_to only: ['foo'] }
    end

    describe 'a seq' do
      let(:value) { ['foo'] }
      it { should serialize_to only: ['foo'] }
    end

    describe 'a map with a str' do
      let(:value) { { only: 'foo' } }
      it { should serialize_to only: ['foo'] }
    end

    describe 'a map with a seq' do
      let(:value) { { only: ['foo'] } }
      it { should serialize_to only: ['foo'] }
    end
  end

  describe 'deploy' do
    let(:schema) { Travis::Yml.expand['deploy'] }

    describe 'a str' do
      let(:value) { 'heroku' }
      it { should serialize_to [provider: 'heroku'] }
    end

    describe 'a seq of strs' do
      let(:value) { ['heroku', 'script'] }
      it { should serialize_to [{ provider: 'heroku' }, { provider: 'script' }] }
    end

    describe 'a map' do
      let(:value) { { provider: 'heroku' } }
      it { should serialize_to [provider: 'heroku'] }
    end

    describe 'a map with an unknown key' do
      let(:value) { { provider: 'heroku', foo: 'foo' } }
      it { should serialize_to [provider: 'heroku', foo: 'foo'] }
    end

    describe 'a seq of maps with an unknown key' do
      let(:value) { [{ provider: 'script' }, { provider: 'heroku', 'foo' => 'foo' }] }
      it { should serialize_to [{ provider: 'script' }, { provider: 'heroku', foo: 'foo' }] }
    end
  end

  describe 'env' do
    let(:schema) { Travis::Yml.expand['env'] }

    describe 'a str' do
      let(:value) { 'foo' }
      it { should serialize_to jobs: [foo: ''] }
    end

    describe 'a seq of strs' do
      let(:value) { ['foo'] }
      it { should serialize_to jobs: [foo: ''] }
    end

    describe 'a var' do
      let(:value) { 'FOO=foo' }
      it { should serialize_to jobs: [FOO: 'foo'] }
    end

    describe 'an empty var' do
      let(:value) { 'FOO=' }
      it { should serialize_to jobs: [FOO: ''] }
    end

    describe 'several vars' do
      let(:value) { 'FOO=foo BAR=bar' }
      it { should serialize_to jobs: [{ FOO: 'foo', BAR: 'bar' }] }
    end

    describe 'a seq of vars' do
      let(:value) { ['FOO=foo BAR=bar', 'BAZ=baz'] }
      it { should serialize_to jobs: [{ FOO: 'foo', BAR: 'bar' }, { BAZ: 'baz' }] }
    end

    describe 'a secure' do
      let(:value) { { 'secure' => 'foo' } }
      it { should serialize_to jobs: [secure: 'foo'] }
    end

    describe 'a seq of secures' do
      let(:value) { [secure: 'foo'] }
      it { should serialize_to jobs: [secure: 'foo'] }
    end

    describe 'a map' do
      let(:value) { { 'FOO' => 'foo', 'BAR' => 'bar' } }
      it { should serialize_to jobs: [{ FOO: 'foo', BAR: 'bar' }] }
    end

    describe 'a seq of maps' do
      let(:value) { [{ 'FOO' => 'foo', 'BAR' => 'bar' }, { 'BAZ' => 'baz' }] }
      it { should serialize_to jobs: [{ FOO: 'foo', BAR: 'bar' }, { BAZ: 'baz' }] }
    end

    describe 'a seq of mixed vars, maps, and secures' do
      let(:value) do
        [
          { 'FOO' => 'foo', 'BAR' => 'bar' },
          { 'BAZ' => 'baz' },
          'BUZ=buz',
          'BAM=bam BUM=bum',
          { 'secure' => 'secure' }
        ]
      end

      it do
        should serialize_to jobs: [
          { FOO: 'foo', BAR: 'bar' },
          { BAZ: 'baz' },
          { BUZ: 'buz' },
          { BAM: 'bam', BUM: 'bum' },
          { secure: 'secure' }
        ]
      end
    end
  end

  describe 'env.jobs' do
    let(:schema) { Travis::Yml.expand['env'] }

    describe 'a str' do
      let(:value) { { jobs: 'foo' } }
      it { should serialize_to jobs: [foo: ''] }
    end

    describe 'a seq of strs' do
      let(:value) { { jobs: ['foo'] } }
      it { should serialize_to jobs: [foo: ''] }
    end

    describe 'a var' do
      let(:value) { { jobs: 'FOO=foo' } }
      it { should serialize_to jobs: [FOO: 'foo'] }
    end

    describe 'a seq of vars' do
      let(:value) { { jobs: ['FOO=foo', 'BAR=bar'] } }
      it { should serialize_to jobs: [{ FOO: 'foo' }, { BAR: 'bar' }] }
    end

    describe 'a secure' do
      let(:value) { { jobs: { secure: 'foo' } } }
      it { should serialize_to jobs: [secure: 'foo'] }
    end

    describe 'a seq of secures' do
      let(:value) { { jobs: [secure: 'foo'] } }
      it { should serialize_to jobs: [secure: 'foo'] }
    end

    describe 'a map' do
      let(:value) { { jobs: { foo: 'foo' } } }
      it { should serialize_to jobs: [foo: 'foo'] }
    end

    describe 'a seq of maps' do
      let(:value) { { jobs: [foo: 'foo'] } }
      it { should serialize_to jobs: [foo: 'foo'] }
    end
  end

  describe 'imports' do
    let(:schema) { Travis::Yml.expand['import'] }

    describe 'a str' do
      let(:value) { 'foo.yml' }
      it { should serialize_to [source: 'foo.yml'] }
    end

    describe 'a seq of strs' do
      let(:value) { ['foo.yml'] }
      it { should serialize_to [source: 'foo.yml'] }
    end

    describe 'a map' do
      let(:value) { { source: 'foo.yml' } }
      it { should serialize_to [source: 'foo.yml'] }
    end

    describe 'seq of maps' do
      let(:value) { [source: 'foo.yml'] }
      it { should serialize_to [source: 'foo.yml'] }
    end
  end

  describe 'jobs.include' do
    let(:schema) { Travis::Yml.expand['jobs'] }

    describe 'a str' do
      let(:value) { { include: ['foo'] } }
      it { should serialize_to value }
    end

    describe 'a seq of strs' do
      let(:value) { { include: ['foo'] } }
      it { should serialize_to value }
    end

    describe 'a map with a str' do
      let(:value) { { include: { language: 'ruby' } } }
      it { should serialize_to include: [language: 'ruby'] }
    end

    describe 'a seq of maps' do
      let(:value) { { include: [language: 'ruby'] } }
      it { should serialize_to include: [language: 'ruby'] }
    end
  end

  describe 'notifications' do
    let(:schema) { Travis::Yml.expand['notifications'] }

    describe 'a str' do
      let(:value) { 'foo' }
      it { should serialize_to email: [recipients: ['foo']] }
    end

    describe 'a seq of strs' do
      let(:value) { ['foo'] }
      it { should serialize_to email: [recipients: ['foo']] }
    end

    describe 'a map with a str' do
      let(:value) { { 'recipients' => 'foo' } }
      it { should serialize_to email: [recipients: ['foo']] }
    end

    describe 'a map with a seq' do
      let(:value) { { 'recipients' => ['foo'] } }
      it { should serialize_to email: [recipients: ['foo']] }
    end

    describe 'seq of maps' do
      let(:value) { ['recipients' => 'foo'] }
      it { should serialize_to email: [recipients: ['foo']] }
    end
  end

  describe 'notifications.email' do
    let(:schema) { Travis::Yml.expand['notifications'] }

    describe 'a str' do
      let(:value) { { email: 'foo' } }
      it { should serialize_to email: [recipients: ['foo']] }
    end

    describe 'a seq of strs' do
      let(:value) { { email: ['foo'] } }
      it { should serialize_to email: [recipients: ['foo']] }
    end

    describe 'a map with a str' do
      let(:value) { { email: { recipients: 'foo' } } }
      it { should serialize_to email: [recipients: ['foo']] }
    end

    describe 'a map with a seq' do
      let(:value) { { email: { recipients: ['foo'] } } }
      it { should serialize_to email: [recipients: ['foo']] }
    end

    describe 'seq of maps' do
      let(:value) { { email: [recipients: 'foo'] } }
      it { should serialize_to email: [recipients: ['foo']] }
    end
  end

  describe 'os' do
    let(:schema) { Travis::Yml.expand['os'] }

    describe 'a str' do
      let(:value) { 'linux' }
      it { should serialize_to ['linux'] }
    end

    describe 'a seq' do
      let(:value) { ['linux'] }
      it { should serialize_to ['linux'] }
    end

    describe 'a map with a str' do
      let(:value) { { name: 'linux' } }
      it { should serialize_to [name: 'linux'] }
    end

    describe 'a map with a seq' do
      let(:value) { { name: ['linux'] } }
      it { should serialize_to [name: ['linux']] }
    end
  end

  describe 'services' do
    let(:schema) { Travis::Yml.expand['services'] }

    describe 'a str' do
      let(:value) { 'redis' }
      it { should serialize_to ['redis'] }
    end

    describe 'a seq' do
      let(:value) { ['redis'] }
      it { should serialize_to ['redis'] }
    end

    describe 'a map with a str' do
      let(:value) { { name: 'redis' } }
      it { should serialize_to [name: 'redis'] }
    end

    describe 'a map with a seq' do
      let(:value) { { name: ['redis'] } }
      it { should serialize_to [name: ['redis']] }
    end
  end

  describe 'stages' do
    let(:schema) { Travis::Yml.expand['stages'] }

    describe 'a str' do
      let(:value) { 'foo' }
      it { should serialize_to [name: 'foo'] }
    end

    describe 'a seq' do
      let(:value) { ['foo'] }
      it { should serialize_to [name: 'foo'] }
    end

    describe 'a map with a str' do
      let(:value) { { name: 'foo' } }
      it { should serialize_to [name: 'foo'] }
    end

    describe 'a map with a seq' do
      let(:value) { { name: ['foo'] } }
      it { should serialize_to [name: 'foo'] }
    end
  end

  describe 'sudo' do
    let(:schema) { Travis::Yml.expand['sudo'] }

    describe 'a str' do
      let(:value) { 'required' }
      it { should serialize_to true }
    end

    describe 'a seq with a str' do
      let(:value) { ['required'] }
      it { should serialize_to true }
    end

    describe 'a map with a str' do
      let(:value) { { name: 'required' } }
      it { should serialize_to name: 'required' }
    end

    describe 'a map with a seq' do
      let(:value) { { name: ['required'] } }
      it { should serialize_to name: ['required'] }
    end
  end
end
