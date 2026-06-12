describe Travis::Yml do
  accept 'priority' do
    describe 'given high (5) at root' do
      yaml %(
        priority: 5
      )
      it { should serialize_to priority: 5 }
      it { should_not have_msg }
    end

    describe 'given default (0) at root' do
      yaml %(
        priority: 0
      )
      it { should serialize_to priority: 0 }
      it { should_not have_msg }
    end

    describe 'given low (-5) at root' do
      yaml %(
        priority: -5
      )
      it { should serialize_to priority: -5 }
      it { should_not have_msg }
    end

    describe 'given an out-of-range integer at root' do
      yaml %(
        priority: 1
      )
      it { should have_msg [:error, :priority, :unknown_value, value: 1] }
    end

    describe 'given a string at root' do
      yaml %(
        priority: high
      )
      it { should have_msg [:error, :priority, :unknown_value, value: 'high'] }
    end

    describe 'on a matrix.include entry' do
      yaml %(
        jobs:
          include:
            - rvm: '2.3'
              priority: 5
      )
      it { should serialize_to jobs: { include: [{ rvm: '2.3', priority: 5 }] } }
      it { should_not have_msg }
    end

    describe 'on a matrix.include entry with low priority' do
      yaml %(
        jobs:
          include:
            - rvm: '2.3'
              priority: -5
      )
      it { should serialize_to jobs: { include: [{ rvm: '2.3', priority: -5 }] } }
      it { should_not have_msg }
    end

    describe 'on a matrix.include entry with an invalid value' do
      yaml %(
        jobs:
          include:
            - rvm: '2.3'
              priority: 99
      )
      it { should have_msg [:error, :'jobs.include.priority', :unknown_value, value: 99] }
    end
  end
end
