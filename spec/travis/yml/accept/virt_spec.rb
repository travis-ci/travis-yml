describe Travis::Yml do
  accept 'virt' do
    describe 'no default' do
      yaml ''
      it { should serialize_to empty }
    end

    known = %w(
      lxd
      vm
    )

    known.each do |value|
      describe "given #{value}" do
        yaml %(
          virt: #{value}
        )
        it { should serialize_to virt: value }
        it { should_not have_msg }
      end
    end

    describe 'ignores case' do
      yaml %(
        virt: VM
      )
      it { should serialize_to virt: 'vm' }
      it { should have_msg [:info, :virt, :downcase, value: 'VM'] }
    end

    describe 'given an unknown value' do
      yaml %(
        virt: unknown
      )
      it { should serialize_to virt: 'unknown' }
      it { should have_msg [:error, :virt, :unknown_value, value: 'unknown'] }
    end

    describe 'given a seq' do
      yaml %(
        virt:
        - vm
      )
      it { should serialize_to virt: 'vm' }
      it { should have_msg [:warn, :virt, :unexpected_seq, value: 'vm'] }
    end

    describe 'on jobs.include' do
      yaml %(
        jobs:
          include:
            - virt: vm
      )
      it { should serialize_to jobs: { include: [virt: 'vm'] } }
      it { should_not have_msg }
    end

    describe 'on jobs.allow_failure' do
      yaml %(
        jobs:
          allow_failures:
            - virt: vm
      )
      it { should serialize_to jobs: { allow_failures: [virt: 'vm'] } }
      it { should_not have_msg }
    end

    describe 'on jobs.exclude' do
      yaml %(
        jobs:
          exclude:
            - virt: vm
      )
      it { should serialize_to jobs: { exclude: [virt: 'vm'] } }
      it { should_not have_msg }
    end

    # describe 'unsupported on arch amd64' do
    #   yaml %(
    #     arch:
    #     - amd64
    #     virt:
    #     - vm
    #   )
    #   it { should serialize_to arch: ['amd64'], virt: 'vm' }
    #   it { should have_msg [:warn, :virt, :unsupported, on_key: 'arch', on_value: 'amd64', key: 'virt', value: 'vm'] }
    # end
  end
end
