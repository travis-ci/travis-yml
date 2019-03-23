require 'awesome_print'
require 'erb'
require 'travis/yml'

AI = {
  indent:        -2,      # Number of spaces for indenting.
  index:         false,  # Display array indices.
  multiline:     true,   # Display in multiple lines.
  plain:         true,   # Use colors.
  ruby19_syntax: true,   # Use Ruby 1.9 hash syntax in output.
}

TPL = ERB.new <<~tpl
describe <%= const.to_s %>, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][<%= name.inspect %>] }

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
        '$ref': '#/definitions/language/<%= name %>'
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
  str = str.gsub('$ref', "'$ref'")
  str = str.gsub('$id', "'$id'")
  str = str.gsub('"', "'")
  str
end

def spec(name)
  const = Travis::Yml::Schema::Dsl::Lang[name]
  schema = Travis::Yml.schema[:definitions][:language][name]
  schema = format(schema)
  schema = schema.split("\n")[1..-2].join("\n")
  schema = indent(schema, 3)
  TPL.result(binding)
end

names = %i(
  android
  c
  clojure
  cpp
  crystal
  csharp
  d
  dart
  elixir
  elm
  erlang
  go
  groovy
  haskell
  haxe
  java
  julia
  nix
  node_js
  objective-c
  perl
  perl6
  php
  python
  r
  ruby
  rust
  scala
  shell
  smalltalk
)
# names = [:crystal]

path = "spec/travis/yml/schema/def/lang/%s_spec.rb"

names.each do |name|
  puts; puts name; puts
  str = spec(name)
  puts str
  File.write(path % name.to_s.gsub('-', '_'), str)
end
