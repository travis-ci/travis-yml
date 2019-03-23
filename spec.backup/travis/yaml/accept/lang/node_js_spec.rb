describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: lang, node_js: '7.0.0', npm_args: 'args' } }
  let(:lang)   { 'node_js' }

  it { expect(config[:language]).to eq 'node_js' }
  it { expect(config[:node_js]).to eq ['7.0.0'] }
  it { expect(config[:npm_args]).to eq 'args' }

  %w(javascript node nodejs node-js node.js).each do |name|
    describe "alias #{name}" do
      let(:lang) { name }
      it { expect(config[:language]).to eq 'node_js' }
    end
  end
end
