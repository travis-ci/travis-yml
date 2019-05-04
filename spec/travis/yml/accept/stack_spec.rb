describe Travis::Yml, 'stack' do
  subject { described_class.apply(parse(yaml), opts) }

  Travis::Yml::Schema::Def::Stack::NAMES.each do |value|
    describe "given #{value}" do
      yaml %(
        stack: #{value}
      )
      it { should serialize_to stack: value.to_s }
      it { should have_msg [:info, :stack, :edge] }
    end
  end

  describe 'downcases' do
    yaml %(
      stack: CONNIE
    )
    it { should serialize_to stack: 'connie' }
  end

  describe 'unknown value' do
    yaml %(
      stack: unknown
    )
    it { should serialize_to stack: 'unknown' }
    it { should have_msg [:error, :stack, :unknown_value, value: 'unknown'] }
  end
end
