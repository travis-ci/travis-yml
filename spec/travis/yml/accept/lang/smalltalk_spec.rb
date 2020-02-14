describe Travis::Yml, 'smalltalk' do
  subject { described_class.load(yaml) }

  describe 'smalltalk' do
    describe 'given a seq of strs' do
      yaml %(
        smalltalk:
        - str
      )
      it { should serialize_to smalltalk: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        smalltalk: str
      )
      it { should serialize_to smalltalk: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'smalltalk_config' do
    describe 'given a seq of strs' do
      yaml %(
        smalltalk_config:
        - str
      )
      it { should serialize_to smalltalk_config: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        smalltalk_config: str
      )
      it { should serialize_to smalltalk_config: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'smalltalk_edge' do
    describe 'given a map' do
      yaml %(
        smalltalk_edge:
          branch: str
          source: str
      )
      it { should serialize_to smalltalk_edge: { branch: 'str', source: 'str' } }
      it { should_not have_msg }
    end
  end
end
