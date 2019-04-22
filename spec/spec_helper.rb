ENV['env'] = 'test'

require 'rack/test'
require 'travis/yml'
require 'travis/yml/web'
require 'support/doc'
require 'support/hash'
require 'support/matchers'
require 'support/node'
require 'support/yaml'

RSpec.configure do |c|
  c.include Spec::Support::Doc
  c.include Spec::Support::Hash
  c.include Spec::Support::Matchers
  c.include Spec::Support::Node
  c.include Spec::Support::Yaml

  # c.before(:suite) { Travis::Yml.write }
end
