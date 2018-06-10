require 'yaml'
require 'timeout'

ENV['REQUESTS'] ||= 'true' if $*.join.include?(File.basename(__FILE__))

def load_config(path)
  LessYAML.load(File.read(path))
end

describe Travis::Yaml do
  # let(:info) { subject.msgs.select { |msg| msg.first == :info } }
  # let(:msgs) { subject.msgs.reject { |msg| msg.first == :info } }
  let(:msgs) { subject.msgs }
  let(:hash) { subject.serialize }

  subject { Timeout.timeout(5) { described_class.apply(config) } }

  paths = ENV['REQUESTS'] ? Dir['spec/fixtures/requests/**/*.yml'] : []

  paths.each do |path|
    # next unless path.include?('6')

    name = path.sub('spec/fixtures/requests/', '').sub('.yml', '')

    describe name do
      let(:config) { load_config(path) }
      # it { p config }
      # it { p hash }
      it { msgs.each { |msg| p msg } }
    end
  end
end
