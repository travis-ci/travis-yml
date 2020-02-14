describe Travis::Yml, 'elixir' do
  subject { described_class.load(yaml) }
  
  describe 'elixir' do
    describe 'given a seq of strs' do
      yaml %(
        elixir:
        - str
      )
      it { should serialize_to elixir: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        elixir: str
      )
      it { should serialize_to elixir: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'otp_release' do
    describe 'given a seq of strs' do
      yaml %(
        otp_release:
        - str
      )
      it { should serialize_to otp_release: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        otp_release: str
      )
      it { should serialize_to otp_release: ['str'] }
      it { should_not have_msg }
    end
  end
end
