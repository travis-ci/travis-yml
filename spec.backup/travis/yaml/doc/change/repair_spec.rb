describe Travis::Yaml::Doc::Change::Repair do
  let(:script) { subject.raw[:script] }

  subject { change(build(nil, :root, value, {})) }

  describe 'given a command broken due to an unquoted colon (1)' do
    let(:value) { { script: [:'$HOME/.cache/pip#before_install' => nil] } }
    it { expect(script).to eq ['$HOME/.cache/pip#before_install:'] }
  end

  describe 'given a command broken due to an unquoted colon (2)' do
    let(:value) { { script: [:'/bin/echo "PLATFORM' => '${NOM_PLATFORM}"'] } }
    it { expect(script).to eq ['/bin/echo "PLATFORM: ${NOM_PLATFORM}"'] }
  end
end
