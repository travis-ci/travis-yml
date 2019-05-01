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

TPL = {
  any: <<~tpl,
    describe <%= const.to_s %>, slow: true do
      describe 'schema' do
        subject { described_class.new.exports[<%= name.inspect %>] }

        xit { puts JSON.pretty_generate(subject) }

        it do
          should eq(
            anyOf: [
              {
                type: :object,<% if properties != 'nil' %>
                properties: <%= properties %>,<% end %>
                prefix: <%= prefix.inspect %>,
                additionalProperties: false
              },
              <%= type %>
            ]
          )
        end
      end
    end
  tpl
  obj: <<~tpl
    describe <%= const.to_s %> do
      describe 'exports' do
        subject { described_class.new.exports[<%= name.inspect %>] }

        xit { puts JSON.pretty_generate(subject) }

        it do
          should eq(
            type: :object,<% if properties != 'nil' %>
            properties: <%= properties %><% end %>,
            additionalProperties: false
          )
        end
      end

      describe 'schema' do
        subject { described_class.new.schema }

        it do
          should eq(
            '$ref': '#/definitions/<%= name %>'
          )
        end
      end
    end
  tpl
}

def except(hash, *keys)
  hash.reject { |key, _| keys.include?(key) }.to_h
end

def indent(str, width)
  str.split("\n").map { |str| (' ' * width) + str }.join("\n")
end

def dump(obj, width)
  str = obj.ai(OPTS).gsub(/ +:/, ':').gsub('::', ': :')
  str = indent(str, width).sub(/^\s*/, '')
  str = str.gsub('$ref', "'$ref'").gsub('"', "'")
  str
end

def spec(name)
  const  = Travis::Yml::Schema::Type::Node[name]
  node   = const.new
  schema = node.exports[name]
  type   = schema.key?(:anyOf) ? :any : :obj
  tpl    = TPL[type]
  width  = tpl =~ /( +).*<%= properties/ && $1.size
  prefix = node.prefix

  properties = type == :any ? schema[:anyOf][0][:properties] : schema[:properties]
  properties = dump(properties, width)

  type = type == :any ? schema[:anyOf][1] : { type: :string }
  type = dump(type, width)

  ERB.new(tpl).result(binding)
end

names = %i(
  flowdock
  hipchat
  irc
  pushover
  slack
  webhooks
)
# names = [:hipchat]

path = "spec/travis/yml/schema/def/notification/%s_spec.rb"

names.each do |name|
  puts; puts name; puts
  str = spec(name)
  puts str
  File.write(path % name, str)
end
