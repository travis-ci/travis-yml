describe Travis::Yml, 'hack' do
  subject { described_class.apply(parse(yaml)) }

  describe 'hhvm' do
    describe 'given a seq of strs' do
      yaml %(
        hhvm:
        - str
      )
      it { should serialize_to hhvm: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        hhvm: str
      )
      it { should serialize_to hhvm: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'php' do
    describe 'given a seq of strs' do
      yaml %(
        php:
        - str
      )
      it { should serialize_to php: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        php: str
      )
      it { should serialize_to php: ['str'] }
      it { should_not have_msg }
    end
  end
end
