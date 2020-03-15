describe Travis::Yml do
  accept 'conditions', drop: true do
    describe 'build' do
      describe 'v0' do
        describe 'branch = master' do
          yaml %(
            conditions: v0
            if: 'branch = master'
          )
          it { should serialize_to if: 'branch = master', conditions: 'v0' }
          it { should_not have_msg }
        end

        describe 'true (bool)' do
          yaml %(
            conditions: v0
            if: true
          )
          it { should have_msg [:error, :if, :invalid_condition, condition: 'true'] }
        end

        describe 'true (str)' do
          yaml %(
            conditions: v0
            if: 'true'
          )
          it { should have_msg [:error, :if, :invalid_condition, condition: 'true'] }
        end
      end

      describe 'v1' do
        describe 'branch = master' do
          yaml %(
            conditions: v1
            if: 'branch = master'
          )
          it { should serialize_to conditions: 'v1', if: 'branch = master' }
          it { should_not have_msg }
        end

        describe 'true (bool)' do
          yaml %(
            conditions: v1
            if: true
          )
          it { should serialize_to conditions: 'v1', if: 'true' }
          it { should_not have_msg }
        end

        describe 'true (str)' do
          yaml %(
            conditions: v1
            if: 'true'
          )
          it { should serialize_to conditions: 'v1', if: 'true' }
          it { should_not have_msg }
        end

        describe 'env()' do
          yaml %(
            conditions: v1
            if: env() = str
          )

          it { should serialize_to conditions: 'v1', if: 'env() = str' }

          with context: :yml do
            it { should_not have_msg }
          end

          with context: :configs do
            it { should have_msg [:info, :'jobs.include', :skip_job, number: 1, condition: 'env() = str'] }
          end
        end

        describe '= foo' do
          yaml %(
            if: '= foo'
          )
          it { should serialize_to empty }
          it { should have_msg [:error, :if, :invalid_condition, condition: '= foo'] }
        end
      end

      describe 'v1 (default)' do
        describe 'branch = master' do
          yaml %(
            if: 'branch = master'
          )
          it { should serialize_to if: 'branch = master' }
          it { should_not have_msg }
        end

        describe 'true' do
          yaml %(
            if: true
          )
          it { should serialize_to if: 'true' }
          it { should_not have_msg }
        end

        describe '= foo' do
          yaml %(
            if: '= foo'
          )
          it { should serialize_to empty }
          it { should have_msg [:error, :if, :invalid_condition, condition: '= foo'] }
        end
      end
    end

    describe 'stages' do
      describe 'true' do
        yaml %(
          stages:
            - if: 'branch = master'
        )
        it { should serialize_to stages: [if: 'branch = master'] }
        it { should_not have_msg }
      end
    end

    describe 'job' do
      describe 'true' do
        yaml %(
          jobs:
            - if: 'branch = master'
        )
        it { should serialize_to jobs: { include: [if: 'branch = master'] } }
        it { should_not have_msg }
      end
    end

    describe 'job.include' do
      describe 'foo !~ [z-a]' do
        yaml %(
          jobs:
            include:
              - if: foo !~ /[z-a]/
        )
        it { should serialize_to jobs: { include: [] } }
        it { should have_msg [:error, :'jobs.include.if', :invalid_condition, condition: 'foo !~ /[z-a]/'] }
      end
    end
  end
end
