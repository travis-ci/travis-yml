describe Travis::Yaml::Spec::Def::NodeJs do
  let(:spec)     { Travis::Yaml.spec }
  let(:support)  { Travis::Yaml.support }
  let(:lang)     { spec[:map][:language][:types][0] }
  let(:node_js)  { support[:map][:node_js][:types][0] }
  let(:npm_args) { support[:map][:npm_args][:types][0] }

  it { expect(lang[:values]).to include(value: 'node_js', alias: ['javascript', 'js', 'node', 'nodejs', 'node-js', 'node.js']) }
  it { expect(node_js[:only][:language]).to include('node_js') }
  it { expect(npm_args[:only][:language]).to include('node_js') }
end
