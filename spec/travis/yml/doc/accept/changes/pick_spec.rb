describe Travis::Yml, 'pick' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'language' do
    describe 'given a seq of strs' do
      yaml %(
        language:
          - ruby
      )
      let(:value) { { language: ['ruby'] } }
      it { should serialize_to language: 'ruby' }
      it { should have_msg [:warn, :language, :unexpected_seq, value: 'ruby'] }
    end

    describe 'given a mixed, nested array' do
      yaml %(
        language:
          - ruby
          - foo: bar
      )
      let(:value) { { language: ['ruby', foo: 'bar'] } }
      it { should serialize_to language: 'ruby' }
      it { should have_msg [:warn, :language, :unexpected_seq, value: 'ruby'] }
    end
  end
end
