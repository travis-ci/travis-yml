describe Travis::Yml, 'source_key' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'not given :alert' do
    let(:opts)  { {} }

    describe 'given a string' do
      yaml %(
        source_key: key
      )
      it { should serialize_to source_key: 'key' }
      it { should_not have_msg }
    end

    describe 'given a secure var' do
      yaml %(
        source_key:
          secure: secure
      )
      it { should serialize_to source_key: { secure: 'secure' } }
      it { should_not have_msg }
    end
  end

  describe 'given :alert' do
    let(:opts)  { { alert: true } }

    describe 'given a string' do
      yaml %(
        source_key: key
      )
      it { should serialize_to source_key: 'key' }
      it { should have_msg [:alert, :source_key, :secure] }
    end

    describe 'given a secure var' do
      yaml %(
        source_key:
          secure: secure
      )
      it { should serialize_to source_key: { secure: 'secure' } }
      it { should_not have_msg }
    end
  end
end
