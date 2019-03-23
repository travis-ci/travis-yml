describe Travis::Yml, 'downcase' do
  subject { described_class.apply(value) }

  describe 'language' do
    describe 'given a downcased string' do
      let(:value) { { language: 'ruby' } }
      it { should_not have_msg }
      it { should serialize_to language: 'ruby' }
    end

    describe 'given an upcased string' do
      let(:value) { { language: 'RUBY' } }
      it { should have_msg [:info, :language, :downcase, value: 'RUBY'] }
      it { should serialize_to language: 'ruby' }
    end
  end
end
