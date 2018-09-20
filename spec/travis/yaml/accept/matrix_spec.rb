describe Travis::Yaml, 'matrix' do
  let(:matrix) { subject.serialize[:matrix] }

  subject { described_class.apply(input) }

  describe 'aliased to :jobs' do
    let(:matrix) { subject.serialize[:matrix] }
    let(:input) { { jobs: { fast_finish: 'true' } } }
    it { expect(matrix[:fast_finish]).to be true }
  end

  describe 'fast_finish' do
    let(:input) { { matrix: { fast_finish: 'true' } } }
    it { expect(matrix[:fast_finish]).to be true }
  end

  describe 'fast_failure (alias)' do
    let(:input) { { matrix: { fast_failure: 'true' } } }
    it { expect(matrix[:fast_finish]).to be true }
  end

  describe 'prefix' do
    describe 'given a hash' do
      let(:input) { { matrix: { rvm: '2.3' } } }
      it { expect(matrix[:include]).to eq [{ rvm: '2.3' }] }
    end

    describe 'given an array of hashes' do
      let(:input) { { matrix: [{ rvm: '2.3' }, { rvm: '2.4' }] } }
      it { expect(matrix[:include]).to eq [{ rvm: '2.3' }, { rvm: '2.4' }] }
      it { msgs.each { |msg| p msg } }
      it { expect(msgs).to be_empty }
    end

    describe 'given an array of strings (misplaced env.matrix)' do
      let(:input) { { matrix: ['FOO=foo'] } }
      it { expect(msgs).to include [:error, :matrix, :invalid_type, expected: :map, actual: :str, value: 'FOO=foo'] }
    end

    describe 'given a misplaced key :allow_failures' do
      let(:input) { { allow_failures: [{ rvm: '2.3' }] } }
      it { expect(matrix[:allow_failures]).to eq [{ rvm: '2.3' }] }
    end

    describe 'given a misplaced alias :allowed_failures (typo)' do
      let(:input) { { allowed_failures: [{ rvm: '2.3' }] } }
      it { expect(matrix[:allow_failures]).to eq [{ rvm: '2.3' }] }
      it { expect(msgs).to include [:warn, :root, :migrate, key: :allow_failures, to: :matrix, value: [rvm: '2.3']] }
    end
  end

  describe 'include' do
    describe 'given true' do
      let(:input) { { matrix: { include: true } } }
      it { expect(matrix).to be nil }
      it { expect(msgs).to include [:error, :"matrix.include", :invalid_type, expected: :map, actual: :bool, value: true] }
    end

    describe 'given an array of hashes' do
      let(:input) { { matrix: { include: [{ rvm: '2.3', stage: 'one' }] } } }
      it { expect(matrix[:include]).to eq [{ rvm: '2.3', stage: 'one' }] }
    end

    describe 'given a hash' do
      let(:input) { { matrix: { include: { rvm: '2.3' } } } }
      it { expect(matrix[:include]).to eq [{ rvm: '2.3' }] }
    end

    describe 'given a nested hash with a version number' do
      let(:input) { { language: 'csharp', matrix: { include: { mono: { '4.0.5env' => 'EDITOR=nvim' } } } } }
      it { expect(matrix).to be_nil }
      it { expect(msgs).to include [:error, :'matrix.include.mono', :invalid_type, expected: :str, actual: :map, value: { :'4.0.5env' => 'EDITOR=nvim' }] }
    end

    describe 'given an array of hashes (with env given as a hash)' do
      let(:input) { { matrix: { include: [{ rvm: '2.3', env: { FOO: 'foo' } }] } } }
      it { expect(matrix[:include]).to eq [{ rvm: '2.3', env: 'FOO=foo' }] }
    end

    describe 'given an array of hashes (with env given as a string)' do
      let(:input) { { matrix: { include: [{ rvm: '2.3', env: 'FOO=foo' }] } } }
      it { expect(matrix[:include]).to eq [{ rvm: '2.3', env: 'FOO=foo' }] }
    end

    describe 'given an array of hashes (with env given as an array of strings)' do
      let(:input) { { matrix: { include: [{ rvm: '2.3', env: ['FOO=foo', 'BAR=bar'] }] } } }
      it { expect(matrix[:include]).to eq [{ rvm: '2.3', env: 'FOO=foo BAR=bar' }] }
    end

    describe 'given a name' do
      let(:input) { { jobs: { include: [name: 'name'] } } }
      it { expect(matrix[:include]).to eq [name: 'name'] }
    end

    describe 'given duplicate names' do
      let(:input) { { jobs: { include: [{ name: 'name' }, { name: 'name' }] } } }
      it { expect(matrix[:include]).to eq [{ name: 'name' }, { name: 'name' }] }
      it { expect(msgs).to include [:warn, :'matrix.include', :duplicate_names, value: ['name']] }
    end

    describe 'given addons' do
      let(:input) { { matrix: { include: [addons: { apt: { packages: ['package'] } }] } } }
      it { expect(matrix[:include]).to eq [{ addons: { apt: { packages: ['package'] } } }] }
      it { expect(msgs).to be_empty }
    end

    describe 'given branches' do
      let(:input) { { matrix: { include: [branches: { only: ['master'] }] } } }
      it { expect(matrix[:include]).to eq [branches: { only: ['master'] }] }
      it { expect(msgs).to be_empty }
    end

    describe 'given a condition' do
      describe 'parses' do
        let(:input) { { matrix: { include: [if: 'branch = main'] } } }
        it { expect(matrix[:include]).to eq [if: 'branch = main'] }
        it { expect(msgs).to be_empty }
      end

      describe 'parse error' do
        let(:input) { { matrix: { include: [script: 'foo', if: 'a NOT b'] } } }
        it { expect { matrix }.to raise_error described_class::InvalidCondition }
      end
    end

    describe 'given a misplaced key' do
      let(:input) { { matrix: { include: { env: { DEBUG: 'true' } } } } }
      it { expect(matrix[:include]).to eq [env: 'DEBUG=true'] }
      it { expect(msgs).to be_empty }
    end

    describe 'given an unknown os' do
      let(:input) { { matrix: { include: { os: 'forth' } } } }
      it { expect(matrix[:include]).to eq [os: 'linux'] }
      it { expect(msgs).to include [:warn, :'matrix.include.os', :unknown_default, value: 'forth', default: 'linux'] }
    end
  end

  [:exclude, :allow_failures].each do |key|
    describe key.to_s do
      describe 'given a hash' do
        let(:input) { { matrix: { key => { rvm: '2.3' } } } }
        it { expect(matrix[key]).to eq [{ rvm: '2.3' }] }
      end

      describe 'given an array of hashes' do
        let(:input) { { matrix: { key => [{ rvm: '2.3' }] } } }
        it { expect(matrix[key]).to eq [{ rvm: '2.3' }] }
      end

      describe 'given true' do
        let(:input) { { matrix: { key => true } } }
        it { expect(matrix).to be nil }
        it { expect(msgs).to include [:error, :"matrix.#{key}", :invalid_type, expected: :map, actual: :bool, value: true] }
      end

      describe 'given an irrelevant key' do
        describe 'with another, relevant key' do
          let(:input) { { matrix: { key => [{ python: '3.5', rvm: '2.3' }] } } }
          it { expect(matrix[key]).to eq [{ rvm: '2.3' }] }
          it { expect(msgs).to include [:error, :"matrix.#{key}.python", :unsupported, on_key: :language, on_value: 'ruby', key: :python, value: '3.5'] }
        end

        describe 'in separate hashes' do
          let(:input) { { matrix: { key => [{ python: '3.5' }, { rvm: '2.3' }] } } }
          it { expect(matrix[key]).to eq [{ rvm: '2.3' }] }
          it { expect(msgs).to include [:error, :"matrix.#{key}.python", :unsupported, on_key: :language, on_value: 'ruby', key: :python, value: '3.5'] }
        end

        describe 'otherwise empty' do
          let(:input) { { matrix: { key => [{ python: '3.5' }] } } }
          it { expect(matrix).to be_nil }
          it { expect(msgs).to include [:error, :"matrix.#{key}.python", :unsupported, on_key: :language, on_value: 'ruby', key: :python, value: '3.5'] }
        end
      end
    end
  end

  describe "allowed_failures (alias)" do
    let(:input) { { matrix: { allowed_failures: { rvm: '2.3' } } } }
    it { expect(matrix[:allow_failures]).to eq [{ rvm: '2.3' }] }
  end

  describe 'allow_failures on root' do
    let(:input) { { allow_failures: [rvm: '2.3'] } }
    it { expect(matrix[:allow_failures]).to eq [{ rvm: '2.3' }] }
    it { expect(msgs).to include [:warn, :root, :migrate, key: :allow_failures, to: :matrix, value: [rvm: '2.3']] }
  end

  describe 'allow_failures given an array of strings (common mistake)' do
    let(:input) { { matrix: { allowed_failures: ['2.3'] } } }
    it { expect(matrix).to be_nil }
    it { expect(msgs).to include [:error, :'matrix.allow_failures', :invalid_type, expected: :map, actual: :str, value: '2.3'] }
  end

  describe 'misplaced keys' do
    let(:input) { { matrix: { include: [{ apt: { packages: ['clang'] } }, { apt: nil }] } } }
    it { expect(matrix).to eq include: [addons: { apt: { packages: ['clang'] } }] }
    it { expect(msgs).to include [:warn, :'matrix.include', :migrate, key: :apt, to: :addons, value: { packages: ['clang'] }] }
    it { expect(msgs).to include [:warn, :'matrix.include', :migrate, key: :apt, to: :addons, value: nil] }
    it { expect(msgs).to include [:warn, :'matrix.include', :empty, key: :include] }
  end

  describe 'misplaced key allow_failures' do
    let(:input) { { allow_failures: [rvm: '2.3'] } }
    it { expect(matrix[:allow_failures]).to eq [{ rvm: '2.3' }] }
    it { expect(msgs).to include [:warn, :root, :migrate, key: :allow_failures, to: :matrix, value: [rvm: '2.3']] }
  end
end
