require 'awesome_print'
require 'travis/yaml'
require 'support/helpers'

RSpec.configure do |c|
  c.include Spec::Helpers
end

if ENV['STACKPROF']
  require 'stackprof'

  RSpec.configure do |c|
    c.before :suite do
      StackProf.start(
        mode: ENV['STACKPROF'].to_sym,
        interval: 1000,
        out: 'tmp/stackprof-cpu-myapp.dump'
      )
    end

    c.after :suite do
      StackProf.stop
      StackProf.results
    end
  end
end
