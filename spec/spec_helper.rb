require 'awesome_print'
require 'travis/yaml'
require 'support/helpers'
require 'support/node'

RSpec.configure do |c|
  c.include Spec::Support::Hash
  c.include Spec::Support::Node

  c.after :suite do
    # `which jq && (bin/spec | jq '.' > spec.json)`
  end
end

if ENV['STACKPROF']
  require 'stackprof'

  RSpec.configure do |c|
    c.before :suite do
      StackProf.start(
        mode: ENV['STACKPROF'].to_sym,
        interval: 1000,
        out: 'tmp/stackprof-cpu-myapp.dump',
        raw: true
      )
    end

    c.after :suite do
      StackProf.stop
      StackProf.results
    end
  end
end
