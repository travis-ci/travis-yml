describe Travis::Yml, 'elm' do
  subject { described_class.apply(parse(yaml)) }

  describe 'elm' do
    describe 'given a seq of strs' do
      yaml %(
        elm:
        - str
      )
      it { should serialize_to elm: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        elm: str
      )
      it { should serialize_to elm: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'node_js' do
    describe 'given a seq of strs' do
      yaml %(
        node_js:
        - str
      )
      it { should serialize_to node_js: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        node_js: str
      )
      it { should serialize_to node_js: ['str'] }
      it { should_not have_msg }
    end
  end

  describe 'elm_format' do
    describe 'given a str' do
      yaml %(
        elm_format: str
      )
      it { should serialize_to elm_format: 'str' }
    end
  end

  describe 'elm_test' do
    describe 'given a str' do
      yaml %(
        elm_test: str
      )
      it { should serialize_to elm_test: 'str' }
    end
  end
end
