describe Travis::Yml, 'downcase' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'language' do
    describe 'given a downcased string' do
      yaml 'language: ruby'
      it { should_not have_msg }
      it { should serialize_to language: 'ruby' }
    end

    describe 'given an upcased string' do
      yaml 'language: RUBY'
      it { should have_msg [:info, :language, :downcase, value: 'RUBY'] }
      it { should serialize_to language: 'ruby' }
    end
  end
end
