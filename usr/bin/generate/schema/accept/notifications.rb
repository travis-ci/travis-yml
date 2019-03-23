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
      it { should validate notifications: { <%= name %>: { <%= key %>: <%= value.inspect.gsub('"', "'") %> } } }<% end %><% values[:invalid].each do |value| %>
      it { should_not validate notifications: { <%= name %>: { <%= key %>: <%= value.inspect.gsub('"', "'") %> } } }<% end %>
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

def examples(prop, name)
  if prop[:type] == :boolean
    {
      valid: [true],
      invalid: [1, name, [name], { foo: 'foo' }, [foo: 'foo']]
    }
  elsif prop[:type] == :number
    {
      valid: [1],
      invalid: [true, name, [name], { foo: 'foo' }, [foo: 'foo']]
    }
  elsif prop[:type] == :string
    {
      valid: [name],
      invalid: [1, true, [name], { foo: 'foo' }, [foo: 'foo']]
    }
  elsif prop == { '$ref': '#/definitions/strs' }
    {
      valid: [name, [name]],
      invalid: [1, true, { foo: 'foo' }, [foo: 'foo']]
    }
  elsif prop == { '$ref': '#/definitions/notification_frequency' }
    {
      valid: ['always'],
      invalid: [1, true]
    }
  else
    fail "missing property type #{prop}"
  end
end

def spec(name)
  const  = Travis::Yml::Schema::Type::Node[name]
  node   = const.new
  schema = node.exports[name]
  type   = schema.key?(:anyOf) ? :any : :obj

  properties = type == :any ? schema[:anyOf][0][:properties] : schema[:properties]
  properties = properties.map { |key, prop| [key, examples(prop, name)] }.to_h

  chomp(TPL.result(binding))
end

names = %i(
  campfire
  email
  flowdock
  hipchat
  irc
  pushover
  slack
  webhooks
)
# names = [:hipchat]

path = "spec/travis/yml/schema/accept/notification/%s_spec.rb"

names.each do |name|
  puts; puts name; puts
  str = spec(name)
  puts str
  File.write(path % name, str)
end
