require 'fileutils'
require 'yaml'

describe Travis::Yml, matrix: true do
  paths = Dir['spec/fixtures/configs/**/*.yml'].sort
  paths = paths[0..1_000]

  configs = paths.map { |path| [path, File.read(path)] }

  configs.each do |path, yaml|
    describe path.sub('spec/fixtures/configs/', '') do
      let(:config) { described_class.apply(parse(yaml), opts).serialize }
      let(:matrix) { described_class.matrix(config: config) }
      let(:path) { path }
      subject { matrix.jobs }
      it { expect { subject }.to_not raise_error }
    end
  end
end
