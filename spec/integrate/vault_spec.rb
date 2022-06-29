require 'fileutils'
require 'yaml'

describe Travis::Yml, integration_configs: true  do
  context "when vault has secure token and it is a root level" do
    let(:yaml)  { File.read('spec/fixtures/vault_configs/root_valid_scenario.yml') }
    let(:config) { described_class.apply(parse(yaml), opts).serialize }
    let(:matrix) { described_class.matrix(config: config) }

    it do
      config = described_class.load(yaml, alert: true, fix: true)
      puts config.serialize
      expect(config.msgs).to eq([])
    end
  end
end