describe Travis::Yml, 'pick' do
  subject { described_class.apply(value) }

  describe 'language' do
    describe 'given a seq of strs' do
      let(:value) { { language: ['ruby'] } }
      it { should serialize_to language: 'ruby' }
      it { should have_msg [:warn, :language, :invalid_seq, value: 'ruby'] }
    end

    describe 'given a mixed, nested array' do
      let(:value) { { language: ['ruby', foo: 'bar'] } }
      it { should serialize_to language: 'ruby' }
      it { should have_msg [:warn, :language, :invalid_seq, value: 'ruby'] }
    end
  end

  describe 'os' do
    describe 'given a nested seq of strs' do
      let(:value) { { os: [['linux', 'osx']] } }
      it { should serialize_to os: ['linux', 'osx'] }
      it { should have_msg [:warn, :os, :invalid_seq, value: ['linux', 'osx']] }
    end
  end
end
