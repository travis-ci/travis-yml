describe Travis::Yml do
  accept 'virt_size' do
    describe 'no default' do
      yaml ''
      it { should serialize_to empty }
    end

    known = %w(
      medium
      large
      x-large
      2x-large
    )

    known.each do |value|
      describe "given #{value}" do
        yaml %(
          virt_size: #{value}
             )
        it { should serialize_to virt_size: value }
        it { should_not have_msg }
      end
    end

    describe 'ignores case' do
      yaml %(
        virt_size: MEDIUM
      )
      it { should serialize_to virt_size: 'medium' }
      it { should have_msg [:info, :virt_size, :downcase, value: 'MEDIUM'] }
    end

    describe 'given an unknown value' do
      yaml %(
        virt_size: unknown
      )
      it { should serialize_to virt_size: 'unknown' }
      it { should have_msg [:error, :virt_size, :unknown_value, value: 'unknown'] }
    end

    describe 'given a seq' do
      yaml %(
        virt_size:
        - medium
      )
      it { should serialize_to virt_size: 'medium' }
      it { should have_msg [:warn, :virt_size, :unexpected_seq, value: 'medium'] }
    end

    describe 'on jobs.include' do
      yaml %(
        jobs:
          include:
            - virt_size: medium
      )
      it { should serialize_to jobs: { include: [virt_size: 'medium'] } }
      it { should_not have_msg }
    end

    describe 'on jobs.allow_failure' do
      yaml %(
        jobs:
          allow_failures:
            - virt_size: medium
      )
      it { should serialize_to jobs: { allow_failures: [virt_size: 'medium'] } }
      it { should_not have_msg }
    end

    describe 'on jobs.exclude' do
      yaml %(
        jobs:
          exclude:
            - virt_size: medium
      )
      it { should serialize_to jobs: { exclude: [virt_size: 'medium'] } }
      it { should_not have_msg }
    end

  end
end
