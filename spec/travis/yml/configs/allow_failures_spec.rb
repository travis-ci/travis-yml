describe Travis::Yml::Configs, 'allow_failures' do
  let(:repo)    { { id: 1, github_id: 1, vcs_id: 1, slug: 'travis-ci/travis-yml', private: false, default_branch: 'master', token: 'repo-token', private_key: 'key', allow_config_imports: true } }
  let(:data)    { {} }
  let(:configs) { described_class.new(repo, 'ref', nil, data, {}) }

  before { stub_repo(repo[:vcs_id], repo[:slug], data: { token: 'user-token' }) } # authorization
  before { stub_content(repo[:id], '.travis.yml', yaml) }

  subject { configs.tap(&:load).jobs }

  describe 'no allowed failures' do
    yaml %(
      rvm:
      - 2.6.5
      - 2.7.0
    )

    it { should eq [{ rvm: '2.6.5' }, { rvm: '2.7.0' }] }
  end

  describe 'default matrix expansion' do
    yaml %(
      rvm:
      - 2.6.5
      - 2.7.0

      gemfile:
      - one
      - two

      jobs:
        allow_failures:
        - rvm: 2.6.5
          gemfile: one
        - rvm: 2.7.0
          gemfile: two

    )

    it do
      should eq [
        { rvm: '2.6.5', gemfile: 'two' },
        { rvm: '2.7.0', gemfile: 'one' },
        { rvm: '2.6.5', gemfile: 'one', allow_failure: true },
        { rvm: '2.7.0', gemfile: 'two', allow_failure: true }
      ]
    end
  end

  describe 'given a branch' do
    yaml %(
      rvm:
      - 2.6.5
      - 2.7.0

      jobs:
        allow_failures:
        - rvm: 2.6.5
          branch: master
    )

    describe 'with the branch name matching' do
      let(:data) { { branch: 'master' } }

      it do
        should eq [
          { rvm: '2.7.0' },
          { rvm: '2.6.5', allow_failure: true },
        ]
      end
    end

    describe 'with the branch name not matching' do
      let(:data) { { branch: 'other' } }

      it do
        should eq [
          { rvm: '2.6.5' },
          { rvm: '2.7.0' },
        ]
      end
    end
  end

  describe 'empty section with condition' do
    yaml %(
      env:
        jobs:
          - ONE=one
          - TWO=two
      jobs:
        allow_failures:
          - if: env(TWO) = two
    )
    it do
      should eq [
        { env: [ONE: 'one'] },
        { env: [TWO: 'two'], allow_failure: true },
      ]
    end
  end

  describe 'does not match if extra env vars are given (1)' do
    yaml %(
      jobs:
        include:
          - env:
            - ONE=one
            - TWO=two
        allow_failures:
            - env: ONE=one
    )
    it do
      should eq [
        { env: [{ ONE: 'one' }, { TWO: 'two' }] },
      ]
    end
  end

  describe 'does not match if extra env vars are given (2)' do
    yaml %(
      jobs:
        include:
          - env: ONE=one TWO=two
        allow_failures:
          - env: TWO=two
    )
    it do
      should eq [
        { env: [{ ONE: 'one', TWO: 'two' }] },
      ]
    end
  end

  describe 'invalid condition' do
    yaml %(
      jobs:
        allow_failures:
          - name: two
            if: '= kaput'

        include:
          - name: one
          - name: two
    )
    it do
      should eq [
        { name: 'one' },
        { name: 'two' },
      ]
    end
  end

  describe 'with stages' do
    yaml %(
      jobs:
        allow_failures:
          - env: ONE=one

        include:
          - stage: one
            env: ONE=one
          - stage: one
            env: TWO=two
          - stage: two
            env: ONE=one
          - stage: two
            env: TWO=two
          - stage: three
            env: ONE=one
          - stage: three
            env: TWO=two
    )

    it do
      should eq [
        { stage: 'one', env: [TWO: 'two'] },
        { stage: 'one', env: [ONE: 'one'], allow_failure: true },
        { stage: 'two', env: [TWO: 'two'] },
        { stage: 'two', env: [ONE: 'one'], allow_failure: true },
        { stage: 'three', env: [TWO: 'two'] },
        { stage: 'three', env: [ONE: 'one'], allow_failure: true },
      ]
    end
  end

  # describe 'wat' do
  #   yaml %(
  #   )
  #   it { p subject }
  # end

  # describe 'matching env' do
  #   let(:config) do
  #     [
  #       {  },
  #     ]
  #   end
  #
  #   let(:jobs) do
  #     [
  #       { rvm: '2.6.5' },
  #       { rvm: '2.7.0' },
  #     ]
  #   end
  #
  #   describe 'with the branch name matching' do
  #     let(:data) { { branch: 'master' } }
  #
  #     it do
  #       should eq [
  #         { rvm: '2.6.5', allow_failure: true },
  #         { rvm: '2.7.0' },
  #       ]
  #     end
  #   end
  #
  #   describe 'with the branch name not matching' do
  #     let(:data) { { branch: 'other' } }
  #
  #     it do
  #       should eq [
  #         { rvm: '2.6.5' },
  #         { rvm: '2.7.0' },
  #       ]
  #     end
  #   end
  # end
  #
  # describe 'ignores global env config when setting allow failures' do
  #   let(:config) do
  #     YAML.load %(
  #       rvm:
  #         - 1.9.3
  #         - 2.0.0
  #       env:
  #         global:
  #           - "GLOBAL=global NEXT_GLOBAL=next"
  #         matrix:
  #           - "FOO=bar"
  #           - "FOO=baz"
  #       matrix:
  #         allow_failures:
  #           - rvm: 1.9.3
  #             env: "FOO=bar"
  #     )
  #   end
  #
  #   it { expect(build.jobs.map(&:allow_failure)).to eq [false, false, false, true] }
  # end
  #
  # describe 'when matrix specifies incorrect allow_failures' do
  #   let(:config) do
  #     YAML.load %(
  #       language: ruby
  #
  #       rvm:
  #         - "1.9.3"
  #         - "2.1.0"
  #
  #       matrix:
  #         fast_finish: true
  #         allow_failures:
  #           - what: "ever"
  #     )
  #   end
  #
  #   it { expect(build.jobs.map(&:allow_failure)).to eq [false, false] }
  # end
  #
  # describe 'conditional allow_failures (1)' do
  #   let(:config) do
  #     YAML.load %(
  #       rvm:
  #         - 1.9.3
  #         - 2.1.0
  #
  #       matrix:
  #         allow_failures:
  #           - rvm: 1.9.3
  #     )
  #   end
  #
  #   it { expect(build.jobs.map(&:allow_failure)).to eq [false, true] }
  # end
  #
  # describe 'conditional allow_failures (2)' do
  #   let(:config) do
  #     YAML.load %(
  #       rvm:
  #         - 1.9.3
  #         - 2.1.0
  #
  #       matrix:
  #         allow_failures:
  #           - rvm: 1.9.3
  #             if: false
  #     )
  #   end
  #
  #   it { expect(build.jobs.map(&:allow_failure)).to eq [false, false] }
  # end
  #
end
