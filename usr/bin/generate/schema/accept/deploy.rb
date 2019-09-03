require 'awesome_print'
require 'erb'
require 'travis/yml'

OPTS = {
  indent:        -2,      # Number of spaces for indenting.
  index:         false,  # Display array indices.
  multiline:     true,   # Display in multiple lines.
  plain:         true,   # Use colors.
  ruby19_syntax: true,   # Use Ruby 1.9 hash syntax in output.
}

TPL = ERB.new <<~tpl
describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:<%= name %>]) }

  describe '<%= name %>' do<% properties.each do |key, values| %>
    describe '<%= key %>' do<% values[:valid].each do |value| %>
      it { should validate deploy: { provider: :<%= name %>, <%= key %>: <%= value.inspect.gsub('"', "'") %> } }<% end %><% values[:invalid].each do |value| %>
      it { should_not validate deploy: { provider: :<%= name %>, <%= key %>: <%= value.inspect.gsub('"', "'") %> } }<% end %>
    end
  <% end %>end
end
tpl

def except(hash, *keys)
  hash.reject { |key, _| keys.include?(key) }.to_h
end

def indent(str, width)
  str.split("\n").map { |str| (' ' * width) + str }.join("\n")
end

def chomp(str)
  str.split("\n").map { |str| str.sub(/ +$/, '') }.join("\n")
end

def examples(prop)
  prop = if prop[:type] == :boolean
    { valid: [true], invalid: [1, 'str', ['str'], { foo: 'foo' }, [foo: 'foo']] }
  elsif prop[:type] == :number
    { valid: [1], invalid: [true, 'str', ['str'], { foo: 'foo' }, [foo: 'foo']] }
  elsif prop[:type] == :string
    { valid: ['str'], invalid: [1, true, ['str'], { foo: 'foo' }, [foo: 'foo']] }
  elsif prop == { '$ref': '#/definitions/strs' }
    { valid: ['str', ['str']], invalid: [1, true, { foo: 'foo' }, [foo: 'foo']] }
  else
    fail "missing property type #{prop}"
  end
end

def spec(name)
  const = Travis::Yml::Schema::Def::Deploy::Providers[name]
  schema = const.new.exports[name][:anyOf][0]
  exports = schema[:properties]
  required = schema[:required]
  properties = except(exports, :provider, :on, :allow_failure, :skip_cleanup, :edge)
  properties = properties.map { |key, prop| [key, examples(prop, required)] }.to_h
  chomp(TPL.result(binding))
end

providers = %i(
  anynines
  appfog
  atlas
  azure_web_apps
  bintray
  bitballoon
  bluemixcf
  boxfuse
  catalyze
  chef_supermarket
  cloud66
  cloudcontrol
  cloudfiles
  cloudfoundry
  codedeploy
  deis
  divshot
  elasticbeanstalk
  engineyard
  firebase
  gae
  gcs
  hackage
  lambda
  launchpad
  modulus
  npm
  openshift
  opsworks
  packagecloud
  pages
  puppetforge
  pypi
  releases
  rubygems
  s3
  scalingo
  script
  surge
  testfairy
)
providers = [:cloudformation, :convox]

path = "spec/travis/yml/schema/accept/deploy/%s_spec.rb"

providers.each do |name|
  puts; puts name; puts
  str = spec(name)
  puts str if name == :lambda
  File.write(path % name, str)
end
