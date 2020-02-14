describe Travis::Yml, 'erlang' do
  subject { described_class.load(yaml) }
  
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
