describe Travis::Yml::Configs, 'conditionals' do
  let(:repo)    { { slug: 'travis-ci/travis-yml' } }
  let(:configs) { described_class.new(repo, 'master', nil, nil, data, opts).tap(&:load) }
  let(:data)    { { branch: 'master', env: [{ SETTING: 'on' }] } }

  let(:config) { configs.config }
  let(:jobs)   { configs.jobs }
  let(:stages) { configs.stages }
  let(:msgs)   { configs.msgs.to_a }

  before { stub_repo(repo[:slug], internal: true, body: repo.merge(token: 'token')) }
  before { stub_content(repo[:slug], '.travis.yml', yaml) }

  describe 'jobs' do
    subject { jobs.size }

    describe 'not matching' do
      yaml %(
        jobs:
          include:
          - if: false
      )

      it { should eq 0 }
      it { should have_msg [:info, :'jobs.include', :skip_job, number: 1, condition: 'false'] }
    end

    describe 'matching branch' do
      yaml %(
        jobs:
          include:
          - if: branch = master
      )

      it { should eq 1 }
      it { should_not have_msg }
    end

    describe 'matching name' do
      yaml %(
        jobs:
          include:
          - name: one
            if: name = one
      )

      xit { should eq 1 }
      xit { should_not have_msg }
    end

    describe 'matching env (given as repo setting)' do
      yaml %(
        jobs:
          include:
          - if: env(SETTING) = on
      )

      it { should eq 1 }
      it { should_not have_msg }
    end

    describe 'matching env (given as env.global)' do
      yaml %(
        env:
          global:
            ONE: one
        jobs:
          include:
          - if: env(ONE) = one
      )

      it { should eq 1 }
      it { should_not have_msg }
    end

    describe 'matching env (given as env.jobs, picking the first entry)' do
      yaml %(
        env:
          jobs:
            ONE: one
        jobs:
          include:
          - if: env(ONE) = one
      )

      it { should eq 1 }
      it { should_not have_msg }
    end

    describe 'matching env (given as jobs.include.env)' do
      yaml %(
        jobs:
          include:
          - env: ONE=one
            if: env(ONE) = one
      )

      it { should eq 1 }
      it { should_not have_msg }
    end

    describe 'invalid condition' do
      yaml %(
        jobs:
          include:
            - name: one
            - name: two
              if: '= kaputt'
      )
      it { should eq 1 }
      it { should have_msg [:error, :'jobs.include.if', :invalid_condition, condition: '= kaputt'] }
    end
  end

  describe 'stages' do
    subject { stages.size }

    describe 'not matching' do
      yaml %(
        stages:
          - name: test
            if: false
        jobs:
          include:
          - name: one
      )

      it { should eq 0 }
      it { should have_msg [:info, :stages, :skip_stage, number: 1, condition: 'false'] }
    end

    describe 'matching branch' do
      yaml %(
        stages:
          - name: test
            if: branch = master
        jobs:
          include:
          - name: one
      )

      it { should eq 1 }
      it { should_not have_msg }
    end

    describe 'matching env (given as repo setting)' do
      yaml %(
        stages:
          - name: test
            if: env(SETTING) = on
        jobs:
          include:
          - name: one
      )

      it { should eq 1 }
      it { should_not have_msg }
    end

    describe 'matching env (given as env.global)' do
      yaml %(
        env:
          global:
            ONE: one
        stages:
          - name: test
            if: env(ONE) = one
      )

      it { should eq 1 }
      it { should_not have_msg }
    end

    describe 'matching env (given as env.jobs)' do
      yaml %(
        env:
          jobs:
            one: one
        stages:
          - name: test
            if: env(one) = one
      )

      it { should eq 0 }
      it { should have_msg [:info, :stages, :skip_stage, number: 1, condition: 'env(one) = one'] }
    end

    describe 'matching env (given as jobs.include.env)' do
      yaml %(
        stages:
          - name: test
            if: env(one) = one
        jobs:
          include:
          - env: one=one
      )

      it { should eq 0 }
      it { should have_msg [:info, :stages, :skip_stage, number: 1, condition: 'env(one) = one'] }
    end

    describe 'invalid condition' do
      yaml %(
        stages:
          - name: test
            if: '= kaputt'
          - name: other
        jobs:
          include:
          - env: ONE=one
      )
      it { should eq 1 }
      it { should have_msg [:error, :'stages.if', :invalid_condition, condition: '= kaputt'] }
    end
  end

  describe 'excludes' do
    subject { jobs.size }

    describe 'not matching' do
      yaml %(
        jobs:
          include:
          - name: one
          exclude:
          - if: false
      )

      it { should eq 1 }
      it { should have_msg [:info, :'jobs.exclude', :skip_exclude, number: 1, condition: 'false'] }
    end

    describe 'matching branch' do
      yaml %(
        jobs:
          include:
          - name: one
          exclude:
          - if: branch = master
      )

      it { should eq 0 }
      it { should_not have_msg }
    end

    describe 'matching env (given as repo setting)' do
      yaml %(
        jobs:
          include:
          - name: one
          exclude:
          - if: env(SETTING) = on
      )

      it { should eq 0 }
      it { should_not have_msg }
    end

    describe 'matching env (given as env.global)' do
      yaml %(
        env:
          global:
            ONE: one
        jobs:
          include:
          - name: one
          exclude:
          - if: env(ONE) = one
      )

      it { should eq 0 }
      it { should_not have_msg }
    end

    describe 'matching env (given as env.jobs, picking the first entry)' do
      yaml %(
        env:
          jobs:
            ONE: one
        jobs:
          include:
          - name: one
          exclude:
          - if: env(ONE) = one
      )

      it { should eq 0 }
      it { should_not have_msg }
    end

    describe 'matching env (given as jobs.include.env)' do
      yaml %(
        jobs:
          include:
          - env: ONE=one
          exclude:
            if: env(ONE) = one
      )

      it { should eq 0 }
      it { should_not have_msg }
    end

    describe 'invalid condition' do
      yaml %(
        jobs:
          include:
          - env: ONE=one
          exclude:
            if: '= kaputt'
      )
      it { should eq 1 }
      it { should have_msg [:error, :'jobs.exclude.if', :invalid_condition, condition: '= kaputt'] }
    end
  end

  describe 'allow_failures' do
    subject { jobs.map { |job| !!job[:allow_failure] } }

    describe 'not matching' do
      yaml %(
        jobs:
          include:
          - name: one
          allow_failures:
          - if: false
      )

      it { expect(subject).to eq [false] }
      it { should have_msg [:info, :'jobs.allow_failures', :skip_allow_failure, number: 1, condition: 'false'] }
    end

    describe 'matching branch' do
      yaml %(
        jobs:
          include:
          - name: one
          allow_failures:
          - if: branch = master
      )

      it { expect(subject).to eq [true] }
      it { should_not have_msg }
    end

    describe 'matching env (given as repo setting)' do
      yaml %(
        jobs:
          include:
          - name: one
          allow_failures:
          - if: env(SETTING) = on
      )

      it { expect(subject).to eq [true] }
      it { should_not have_msg }
    end

    describe 'matching env (given as env.global)' do
      yaml %(
        env:
          global:
            ONE: one
        jobs:
          include:
          - name: one
          allow_failures:
          - if: env(ONE) = one
      )

      it { expect(subject).to eq [true] }
      it { should_not have_msg }
    end

    describe 'matching env (given as env.jobs, picking the first entry)' do
      yaml %(
        env:
          jobs:
            ONE: one
        jobs:
          include:
          - name: one
          allow_failures:
          - if: env(ONE) = one
      )

      it { expect(subject).to eq [true] }
      it { should_not have_msg }
    end

    describe 'matching env (given as jobs.include.env)' do
      yaml %(
        jobs:
          include:
          - env: ONE=one
          allow_failures:
          - if: env(ONE) = one
      )

      it { expect(jobs.size).to eq 1 }
      it { should_not have_msg }
    end

    describe 'invalid condition' do
      yaml %(
        jobs:
          include:
          - env: ONE=one
          allow_failures:
          - if: '= kaputt'
      )
      it { should eq [false] }
      it { should have_msg [:error, :'jobs.allow_failures.if', :invalid_condition, condition: '= kaputt'] }
    end
  end

  describe 'notifications' do
    subject { config[:notifications] }

    describe 'not matching' do
      yaml %(
        notifications:
          email:
          - if: false
      )

      it { expect(subject).to be_nil }
      it { should have_msg [:info, :'notifications.email', :skip_notification, type: :email, number: 1, condition: 'false'] }
    end

    describe 'matching branch' do
      yaml %(
        notifications:
          email:
          - if: branch = master
      )

      it { expect(subject.size).to eq 1 }
      it { should_not have_msg }
    end

    describe 'matching env (given as repo setting)' do
      yaml %(
        notifications:
          email:
          - if: env(SETTING) = on
      )

      it { expect(subject.size).to eq 1 }
      it { should_not have_msg }
    end

    describe 'matching env (given as env.global)' do
      yaml %(
        env:
          global:
            ONE: one
        notifications:
          email:
          - if: env(ONE) = one
      )

      it { expect(subject.size).to eq 1 }
      it { should_not have_msg }
    end

    describe 'matching env (given as env.notifications, picking the first entry)' do
      yaml %(
        env:
          jobs:
            ONE: one
        notifications:
          email:
          - if: env(ONE) = one
      )

      it { expect(subject).to be_nil } # notifications are not per job
      it { should have_msg [:info, :'notifications.email', :skip_notification, type: :email, number: 1, condition: 'env(ONE) = one'] }
    end

    describe 'matching env (given as notifications.include.env)' do
      yaml %(
        jobs:
          include:
          - env: ONE=one
        notifications:
          email:
          - if: env(ONE) = one
      )

      it { expect(subject).to be_nil } # notifications are not per job
      it { should have_msg [:info, :'notifications.email', :skip_notification, type: :email, number: 1, condition: 'env(ONE) = one'] }
    end

    describe 'invalid condition' do
      yaml %(
        jobs:
          include:
          - env: ONE=one
        notifications:
          email:
          - recipients: 'me@email.com'
            if: '= kaputt'
      )
      it { expect(subject).to be_nil }
      it { expect(msgs).to include [:error, :'notifications.email.if', :invalid_condition, condition: '= kaputt'] }
    end
  end
end
