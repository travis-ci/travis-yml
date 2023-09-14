describe Travis::Yml::Configs do
  let(:repo)    { { id: 1, github_id: 1, slug: 'travis-ci/travis-yml', private: false, default_branch: 'master', token: 'repo-token', private_key: 'key', allow_config_imports: true, vcs_type: vcs_type, vcs_id: 1 } }
  let(:raw)     { nil }
  let(:data)    { nil }
  let(:opts)    { { token: 'user-token', data: data } }
  let(:configs) { described_class.new(repo, 'ref',  raw ? [config: raw, mode: nil] : nil, data, opts) }

  let(:config)  { subject.config }
  let(:jobs)    { subject.jobs }
  let(:stages)  { subject.stages }
  let(:msgs)    { subject.msgs.to_a }

  let(:vcs_type) { 'GithubRepository' }

  before { stub_repo(repo[:vcs_id], repo[:slug], data: { token: 'user-token' }) } # authorization
  before { stub_content(repo[:id], '.travis.yml', yaml) }

  subject { configs.tap(&:load) }

  describe 'conditional jobs' do
    describe 'matching data' do
      yaml %(
        jobs:
          include:
          - name: one
            if: type = api
      )

      let(:data) { { type: 'push' } }

      it { expect(msgs).to include [:info, :'jobs.include', :skip_job, number: 1, condition: 'type = api'] }
    end

    describe 'matching env in config' do
      let(:raw) { 'env: ONE=one TWO=two' }

      yaml %(
        jobs:
          include:
          - name: one
            if: env(ONE) = two
      )

      it { expect(msgs).to include [:info, :'jobs.include', :skip_job, number: 1, condition: 'env(ONE) = two'] }
    end

    describe 'matching env.global in config' do
      let(:raw) { 'env: { global: ONE=one }' }

      yaml %(
        jobs:
          include:
          - name: one
            if: env(ONE) = two
      )

      it { expect(msgs).to include [:info, :'jobs.include', :skip_job, number: 1, condition: 'env(ONE) = two'] }
    end
  end

  describe 'conditional exclude' do
    describe 'matching request type' do
      yaml %(
        jobs:
          include:
            - name: one
          exclude:
          - name: one
            if: type = api
      )

      let(:data) { { type: 'push' } }

      it { expect(msgs).to include [:info, :'jobs.exclude', :skip_exclude, number: 1, condition: 'type = api'] }
    end

    describe 'matching default stage name' do
      yaml %(
        env:
          - ONE=one
          - TWO=two
        jobs:
          exclude:
          - env: TWO=two
            stage: test
      )

      it { expect(jobs).to eq [env: [ONE: 'one']] }
    end
  end

  describe 'conditional notifications' do
    yaml %(
      notifications:
        email:
          if: branch = master
    )

    describe 'condition matching branch' do
      let(:data) { { branch: 'master' } }
      it { expect(config[:notifications]).to eq email: [if: 'branch = master'] }
    end

    describe 'condition not matching branch' do
      let(:data) { { branch: 'other' } }
      it { expect(config[:notifications]).to eq email: [] }
    end
  end

  describe 'allow_failures' do
    describe 'with with env.global' do
      yaml %(
        env:
          global:
            - FOO=foo
        jobs:
          include:
            - env: BAR=bar
            - env: BAZ=baz
          allow_failures:
            - env: BAZ=baz
      )

      it { expect(jobs.map { |c| c[:allow_failure] }).to eq [nil, true] }
    end

    describe 'matching both include.jobs.env and env.global' do
      yaml %(
        env:
          global:
            - FOO=foo
        jobs:
          include:
            - env: BAR=bar
          allow_failures:
            - env:
              - FOO=foo
              - BAR=bar
      )

      it { expect(jobs.map { |c| c[:allow_failure] }).to eq [true] }
    end

    describe 'with stages' do
      describe 'no stages section' do
        yaml %(
          jobs:
            include:
              - name: one
                stage: one
              - name: two
              - name: three
                stage: two
              - name: four
            allow_failures:
              - name: one
              - name: four
        )

        it do
          expect(stages).to eq [
            { name: 'one' },
            { name: 'two' }
          ]
        end

        it do
          expect(jobs).to eq [
            { name: 'two',   stage: 'one' },
            { name: 'one',   stage: 'one', allow_failure: true },
            { name: 'three', stage: 'two' },
            { name: 'four',  stage: 'two', allow_failure: true }
          ]
        end
      end

      describe 'no stages section' do
        yaml %(
          stages:
            - one
            - two
          jobs:
            include:
              - name: three
                stage: two
              - name: four
              - name: two
                stage: one
              - name: one
              - name: six
                stage: three
              - name: five
            allow_failures:
              - name: two
              - name: four
              - name: six
        )

        it do
          expect(stages).to eq [
            { name: 'one' },
            { name: 'two' },
            { name: 'three' }
          ]
        end

        it do
          expect(jobs).to eq [
            { name: 'one',   stage: 'one' },
            { name: 'two',   stage: 'one', allow_failure: true },
            { name: 'three', stage: 'two' },
            { name: 'four',  stage: 'two', allow_failure: true },
            { name: 'five',  stage: 'three' },
            { name: 'six',   stage: 'three', allow_failure: true }
          ]
        end
      end
    end

    describe 'stages' do
      describe 'capitalized stage name Test in stages' do
        yaml %(
          stages:
            - name: Other
            - name: Test
          env:
            jobs:
              - ONE=one
              - TWO=two
          jobs:
            include:
              - stage: Other
                name: other
              - stage: Test
                name: test
        )

        it do
          expect(jobs).to eq [
            { stage: 'Other', name: 'other', env: [ONE: 'one'] },
            { stage: 'Test', env: [ONE: 'one'] },
            { stage: 'Test', env: [TWO: 'two'] },
            { stage: 'Test', name: 'test', env: [ONE: 'one'] },
          ]
        end

        it do
          expect(stages).to eq [
            { name: 'Other' },
            { name: 'Test' },
          ]
        end
      end

      describe 'capitalized stage name Test in jobs' do
        yaml %(
          stages:
            - name: other
            - name: test
          env:
            jobs:
              - ONE=one
              - TWO=two
          jobs:
            include:
              - stage: Other
                name: other
              - stage: Test
                name: test
        )

        it do
          expect(jobs).to eq [
            { stage: 'Other', name: 'other', env: [ONE: 'one'] },
            { stage: 'test', env: [ONE: 'one'] },
            { stage: 'test', env: [TWO: 'two'] },
            { stage: 'Test', name: 'test', env: [ONE: 'one'] },
          ]
        end

        it do
          expect(stages).to eq [
            { name: 'other' },
            { name: 'test' },
          ]
        end
      end
    end
  end

  describe 'matrix expansion does not alter the merged request config' do
    yaml %(
      env:
        global:
        - ONE=one
      jobs:
        include:
          - name: one
          - name: two
    )

    let(:data) { { type: 'push' } }

    it { expect(config).to eq env: { global: [ONE: 'one'] }, jobs: { include: [{ name: 'one' }, { name: 'two' }] } }
  end

  describe 'invalid stage section' do
    let(:data) { { branch: 'master' } }

    yaml %(
      stage:
      - name: one
    )

    it { expect { jobs }.to_not raise_error }
  end

  describe 'github api errors' do
    yaml 'import: one/one.yml'

    describe 'on .travis_yml' do
      before { stub_content(repo[:id], '.travis.yml', status: status) }

      describe '401' do
        let(:status) { 401 }
        it { expect { subject }.to raise_error Travis::Yml::Configs::Unauthorized }
      end

      describe '404 (api build request)' do
        let(:raw) { 'script: ./api' }
        let(:status) { 404 }
        it { expect { subject }.to_not raise_error }
      end

      describe '404 (non-api build request)' do
        let(:status) { 404 }
        it { expect { subject }.to raise_error Travis::Yml::Configs::FileNotFound }
      end

      describe '500' do
        let(:status) { 500 }
        it { expect { subject }.to raise_error Travis::Yml::Configs::ServerError }
      end
    end

    describe 'on import' do
      before { stub_content(repo[:id], 'one/one.yml', status: status) }

      describe '401' do
        let(:status) { 401 }
        it { expect { subject }.to raise_error Travis::Yml::Configs::Unauthorized }
      end

      describe '404 (api build request)' do
        let(:raw) { 'script: ./api' }
        let(:status) { 404 }
        it { expect { subject }.to raise_error Travis::Yml::Configs::FileNotFound }
      end

      describe '404 (non-api build request)' do
        let(:status) { 404 }
        it { expect { subject }.to raise_error Travis::Yml::Configs::FileNotFound }
      end

      describe '500' do
        let(:status) { 500 }
        it { expect { subject }.to raise_error Travis::Yml::Configs::ServerError }
      end
    end
  end

  describe 'travis api errors' do
    yaml 'import: other/other:one/one.yml'

    before { stub_repo(2, 'other/other', data: { internal: true, status: status }, by_slug: true) }
    before { stub_content(2, 'one.yml', 'script: ./one') }

    describe '401' do
      let(:status) { 401 }

      context 'Default Github provider' do
        it { expect { subject }.to raise_error Travis::Yml::Configs::Unauthorized }
      end

      context 'Other VCS provider' do
        let(:vcs_type) { 'BitbucketRepository' }
        let(:provider) { 'bitbucket' }

        before { stub_repo(2, 'other/other', data: { internal: true, status: status }, provider: provider, by_slug: true) }

        it { expect { subject }.to raise_error Travis::Yml::Configs::Unauthorized }
      end
    end

    describe '403' do
      let(:status) { 403 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::Unauthorized }
    end

    describe '404' do
      let(:status) { 404 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::RepoNotFound }
    end

    describe '500' do
      let(:status) { 500 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::ServerError }
    end
  end

  # describe 'wat' do
  #   yaml %(
  #   )
  #
  #   it { p jobs }
  # end
end
