ENV['RACK_ENV'] = ENV['ENV'] = 'test'

require 'base64'
require 'rack/test'
require 'webmock/rspec'
require 'travis/yml'
require 'travis/yml/web'
require 'support'

Travis::Yml.metrics

RSpec.configure do |c|
  c.include Spec::Support::Doc
  c.include Spec::Support::Hash
  c.include Spec::Support::Matchers
  c.include Spec::Support::Node
  c.include Spec::Support::Webmock
  c.include Spec::Support::Yaml
  c.include Base64

  c.before(:suite) { Travis::Yml.write }
end
