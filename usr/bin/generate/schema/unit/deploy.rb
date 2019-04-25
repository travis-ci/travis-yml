require 'awesome_print'
require 'erb'
require 'travis/yml'

AI = {
  indent:        -2,     # Number of spaces for indenting.
  index:         false,  # Display array indices.
  multiline:     true,   # Display in multiple lines.
  plain:         true,   # Use colors.
  ruby19_syntax: true,   # Use Ruby 1.9 hash syntax in output.
}

TPL = ERB.new <<~tpl
describe <%= const %>, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:deploy][:<%= name %>] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
      <%= schema %>
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/deploy/<%= name %>'
      )
    end
  end
end
tpl

def except(hash, *keys)
  hash.reject { |key, _| keys.include?(key) }.to_h
end

def indent(str, width)
  lines = str.split("\n")
  [lines.shift, lines.map { |str| (' ' * width * 2) + str }].join("\n")
end

def format(obj)
  str = obj.ai(AI)
  str = str.gsub(/(\w+) +:/, '\1:')
  str = str.gsub(/' +:/, '"')
  str = str.gsub('$ref', "'$ref'")
  str = str.gsub('$id', "'$id'")
  str = str.gsub('"', "'")
  str
end

def spec(name)
  const = Travis::Yml::Schema::Dsl::Node.lookup(name)
  schema = Travis::Yml.schema[:definitions][:deploy][name]
  schema = format(schema)
  schema = schema.split("\n")[1..-2].join("\n")
  schema = indent(schema, 3)
  TPL.result(binding)
end

providers = %i(
  anynines
  appfog
  atlas
  azure_web_apps
  bintray
  bitballoon
  bluemixcloudfoundry
  boxfuse
  catalyze
  chef-supermarket
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
  heroku
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
  # heroku
# providers = [:atlas]

path = "spec/travis/yml/schema/def/deploy/%s_spec.rb"

providers.each do |name|
  puts; puts name; puts
  str = spec(name)
  puts str
  File.write(path % name, str)
end
