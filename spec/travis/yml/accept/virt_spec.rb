describe Travis::Yml, 'virt' do
  subject { described_class.apply(parse(yaml), opts) }

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
