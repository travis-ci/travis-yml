require 'yaml'

ENV['REQUESTS'] ||= 'true' if $*.join.include?(File.basename(__FILE__))

def load_config(path)
  YAML.load(File.read(path))
end

describe Travis::Yaml do
  let(:msgs) { subject.msgs.reject { |msg| msg.first == :info } }
  let(:hash) { subject.to_h }

  subject { described_class.apply(config) }

  paths = ENV['REQUESTS'] ? Dir['spec/fixtures/requests/**/*.yml'] : []

  paths.each do |path|
    # next if SKIP.any? { |skip| path.include?(skip) }

    name = path.sub('spec/fixtures/requests/', '').sub('.yml', '')

    describe name do
      let(:config) { load_config(path) }
      it { expect(msgs).to include [] }
    end
  end
end
