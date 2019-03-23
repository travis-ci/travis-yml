describe Travis::Yml, 'sudo' do
  subject { described_class.apply(parse(yaml)) }

  describe 'no default' do
    yaml %(
      language: ruby
    )
    it { should serialize_to language: 'ruby' }
    it { should_not have_msg }
  end

  describe 'given true' do
    yaml %(
      sudo: true
    )
    it { should serialize_to sudo: true }
    it { should_not have_msg }
  end

  describe 'given the string on' do
    yaml %(
      sudo: on
    )
    it { should serialize_to sudo: true }
    it { should_not have_msg }
  end

  describe 'given the string yes' do
    yaml %(
      sudo: yes
    )
    it { should serialize_to sudo: true }
    it { should_not have_msg }
  end

  describe 'given the string enabled' do
    yaml %(
      sudo: enabled
    )
    it { should serialize_to sudo: true }
    it { should_not have_msg }
  end

  describe 'given the string required' do
    yaml %(
      sudo: required
    )
    it { should serialize_to sudo: true }
    it { should_not have_msg }
  end

  describe 'given false' do
    yaml %(
      sudo: false
    )
    it { should serialize_to sudo: false }
    it { should_not have_msg }
  end

  describe 'given the string off' do
    yaml %(
      sudo: off
    )
    it { should serialize_to sudo: false }
    it { should_not have_msg }
  end

  describe 'given the string no' do
    yaml %(
      sudo: no
    )
    it { should serialize_to sudo: false }
    it { should_not have_msg }
  end

  describe 'given the string disabled' do
    yaml %(
      sudo: disabled
    )
    it { should serialize_to sudo: false }
    it { should_not have_msg }
  end

  describe 'given the string not required' do
    yaml %(
      sudo: 'not required'
    )
    it { should serialize_to sudo: false }
    it { should_not have_msg }
  end
end
