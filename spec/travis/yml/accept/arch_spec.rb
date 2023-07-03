describe Travis::Yml do
  accept 'arch' do
    known = %w(
      amd64
      arm64
      arm64-graviton2
      ppc64le
      s390x
    )

    known.each do |value|
      describe "given #{value}" do
        yaml %(
          arch: #{value}
        )
        it { should serialize_to arch: [value] }
        it { should_not have_msg }
      end
    end

    describe 'given an alias' do
      yaml %(
        arch: power
      )
      it { should serialize_to arch: ['ppc64le'] }
    end

    describe 'given a seq' do
      yaml %(
        arch:
        - amd64
        - ppc64le
      )
      it { should serialize_to arch: ['amd64', 'ppc64le'] }
    end

    describe 'given a seq with an alias' do
      yaml %(
        arch:
        - amd64
        - power
      )
      it { should serialize_to arch: ['amd64', 'ppc64le'] }
    end

    describe 'downcases (given a string)' do
      yaml %(
        arch: AMD64
      )
      it { should serialize_to arch: ['amd64'] }
    end

    describe 'downcases (given a seq)' do
      yaml %(
        arch:
        - AMD64
        - PPC64LE
      )
      it { should serialize_to arch: ['amd64', 'ppc64le'] }
    end

    describe 'given a map', drop: true do
      yaml %(
        arch:
          name: amd64
      )
      it { should serialize_to arch: [] }
      it { should have_msg [:error, :arch, :invalid_type, expected: :str, actual: :map, value: { name: 'amd64' }] }
    end

    describe 'given an unknown value' do
      yaml %(
        arch: unknown
      )
      it { should serialize_to arch: ['unknown'] }
      it { should have_msg [:error, :arch, :unknown_value, value: 'unknown'] }
    end

    describe 'given a seq with an unknown value' do
      yaml %(
        arch:
        - amd64
        - unknown
      )
      it { should serialize_to arch: ['amd64', 'unknown'] }
      it { should have_msg [:error, :arch, :unknown_value, value: 'unknown'] }
    end

    describe 'arm is available on: osx' do
      yaml %(
        os: osx
        arch: arm64
      )
      it { should serialize_to os: ['osx'], arch: ['arm64'] }
    end
  end
end
