describe Travis::Yml::Docs::Examples do
  let(:root) { Travis::Yml::Docs::Schema::Factory.build(nil, Travis::Yml.schema) }

  describe 'archs' do
    subject { root[:arch].examples }

    it do
      should eq [
        { arch: ['amd64', 'arm64'] },
        { arch: 'amd64' }
      ]
    end
  end

  describe 'branches' do
    subject { root.includes[0][:branches].examples }

    it do
      should eq [
        { branches: { only: ['master'], except: ['develop'] } },
        { branches: ['master'] },
        { branches: 'master' }
      ]
    end
  end

  describe 'cache' do
    subject { root.includes[0][:cache].examples }

    it do
      should eq [
        { cache: { directories: ['./path'], apt: true, bundler: true } },
        { cache: false }
      ]
    end
  end

  describe 'compilers' do
    subject { root[:compiler].examples }

    it do
      should eq [
        { compiler: ['gcc'] },
        { compiler: 'gcc' }
      ]
    end
  end

  describe 'conditions' do
    subject { root.includes[0][:if].examples }

    it do
      should eq [
        if: 'branch = master'
      ]
    end
  end

  describe 'dist' do
    subject { root[:dist].examples }

    it do
      should eq [
        { dist: 'trusty' },
        { dist: 'precise' }
      ]
    end
  end

  describe 'env' do
    subject { root[:env].examples }

    it do
      should eq [
        { env: { global: [{ FOO: 'foo' }], matrix: [{ FOO: 'foo' }] } },
        { env: [{ FOO: 'foo' }] },
        { env: [{ secure: 'encrypted string' }] },
        { env: ['FOO=foo'] },
        { env: { FOO: 'foo' } },
        { env: { secure: 'encrypted string' } },
        { env: 'FOO=foo' }
      ]
    end
  end

  describe 'git' do
    subject { root.includes[0][:git].examples }

    it do
      should eq [
        { git: { strategy: 'clone', quiet: true, depth: 1 } },
        { git: { depth: true } }
      ]
    end
  end

  describe 'import' do
    subject { root[:import].examples }

    it do
      should eq [
        { import: [{ source: './import.yml@v1', mode: 'merge' }] },
        { import: ['./import.yml@v1'] },
        { import: { source: './import.yml@v1', mode: 'merge' } },
        { import: './import.yml@v1' }
      ]
    end
  end

  describe 'language' do
    subject { root[:language].examples }

    it do
      should eq [
        language: 'ruby'
      ]
    end
  end

  describe 'oss' do
    subject { root[:os].examples }

    it do
      should eq [
         { os: ['linux', 'osx'] },
         { os: 'linux' }
      ]
    end
  end

  describe 'services' do
    subject { root.includes[0][:services].examples }

    it do
      should eq [
        { services: ['postgresql', 'redis'] },
        { services: 'postgresql' }
      ]
    end
  end

  describe 'stages' do
    subject { root[:stages].examples }

    it do
      should eq [
        { stages: [{ name: 'unit tests', if: 'branch = master' }] },
        { stages: ['unit tests'] },
        { stages: { name: 'unit tests', if: 'branch = master' } },
        { stages: 'unit tests' }
      ]
    end
  end
end
