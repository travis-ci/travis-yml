describe Travis::Yml, 'arch' do
  subject { described_class.apply(parse(yaml), opts) }

  known = %w(
    amd64
    ppc64le
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

  describe 'given a map' do
    yaml %(
      arch:
        name: amd64
    )
    it { should serialize_to empty }
    it { should have_msg [:error, :arch, :invalid_type, expected: :str, actual: :map, value: { name: 'amd64' }] }
  end

  describe 'given an unknown value' do
    yaml %(
      arch: unknown
    )
    it { should serialize_to empty }
    it { should have_msg [:error, :arch, :unknown_value, value: 'unknown'] }
  end

  describe 'given a seq with an unknown value' do
    yaml %(
      arch:
      - amd64
      - unknown
    )
    it { should serialize_to arch: ['amd64'] }
    it { should have_msg [:error, :arch, :unknown_value, value: 'unknown'] }
  end

  describe 'no-op for os: osx' do
    yaml %(
      os: osx
      arch: amd64
    )
    it { should serialize_to os: ['osx'], arch: ['amd64'] }
    it { should have_msg [:warn, :arch, :unsupported, on_key: 'os', on_value: 'osx', key: 'arch', value: ['amd64']] }
  end
end
