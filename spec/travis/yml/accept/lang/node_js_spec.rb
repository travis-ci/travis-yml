describe Travis::Yml, 'node_js' do
  subject { described_class.load(yaml) }

  describe 'node' do
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

  describe 'npm_args' do
    describe 'given a str' do
      yaml %(
        npm_args: str
      )
      it { should serialize_to npm_args: 'str' }
    end
  end
end
