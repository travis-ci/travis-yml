describe LessYAML do
  subject { described_class.load(yaml) }

  describe 'loading true' do
    yaml 'true'
    it { should eq true }
  end

  describe 'loading false' do
    yaml 'false'
    it { should eq false }
  end

  describe 'loading yes' do
    yaml 'yes'
    it { should eq 'yes' }
  end

  describe 'loading no' do
    yaml 'no'
    it { should eq 'no' }
  end

  describe 'loading on' do
    yaml 'on'
    it { should eq 'on' }
  end

  describe 'loading off' do
    yaml 'off'
    it { should eq 'off' }
  end

  describe 'loading a string' do
    yaml 'str'
    it { should eq 'str' }
  end

  describe 'loading an integer' do
    yaml '1'
    it { should eq 1 }
  end

  describe 'loading a float' do
    yaml '1.10'
    it { should eq '1.10' }
  end

  describe 'loading a sequence with a float' do
    yaml '- 1.10'
    it { should eq ['1.10'] }
  end

  describe 'loading a map with a float' do
    yaml 'str: 1.10'
    it { should eq 'str' => '1.10' }
  end

  describe 'loading a binary' do
    yaml %(
      secure: !!binary |
        T21OL05XaVhRNkpR
    )
    it { should eq 'secure' => 'OmN/NWiXQ6JQ' }
  end
end
