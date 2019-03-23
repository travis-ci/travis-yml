class Change < Struct.new(:schema, :obj); end

class Wrap < Change
  def apply
    wrap? ? wrap : obj
  end

  def wrap?
    schema[:type] == :array && !obj.is_a?(Array)
  end

  def wrap
    puts "[#{self.class}] schema #{schema[:id].inspect} (#{schema[:type]}) wrapping #{obj}" if $log
    [obj]
  end
end

class Pick < Change
  def apply
    pick? ? pick : obj
  end

  def pick?
    obj.is_a?(Array) && obj.first.is_a?(type(schema)) # && [:env_vars, :env_var].include?(schema[:id])
  end

  def pick
    puts "[#{self.class}] schema #{schema[:id].inspect} (#{schema[:type]}) picking from #{obj}" if $log
    obj.first
  end
end

class Prefix < Change
  def apply
    prefix? ? prefix : obj
  end

  def prefix?
    schema[:prefix] && !known_keys?(obj)
  end

  def known_keys?(obj)
    case obj
    when Hash  then obj.keys.any? { |key| schema[:properties].keys.include?(key) }
    when Array then known_keys?(obj.first)
    end
  end

  def prefix
    puts "[#{self.class}] schema #{schema[:id].inspect} (#{schema[:type]}) prefixing (#{schema[:prefix]}) #{obj}" if $log
    { schema[:prefix] => obj }
  end
end

class Var < Change
  def apply
    parse? ? parse : obj
  end

  def parse?
    obj.is_a?(String) && obj.include?('=')
  end

  def parse
    puts "[#{self.class}] schema #{schema[:id].inspect} (#{schema[:type]}) parsing #{obj}" if $log
    obj.split(' ').map do |vars|
      [vars.split('=')].map { |key, obj| [key.to_sym, obj] }
    end.flatten(1).to_h
  end
end

class Vars < Change
  def apply
    split? ? split : obj
  end

  def split?
    obj.is_a?(Array) && obj.all? { |obj| obj.is_a?(Hash) } # && schema[:id] == :env_vars
  end

  def split
    puts "[#{self.class}] splitting #{obj}" if $log
    obj.map { |vars| vars.map { |key, value| { key => value } } }.flatten(1)
  end
end

# $log = true

CHANGES = {
  object: [Prefix, Pick, Var],
  array:  [Pick, Wrap, Vars],
  string: [Pick],
}

def changes(type)
  [CHANGES[type]]
end

def matches?(schema, obj)
  send(:"matches_#{schema[:type]}?", schema, obj)
end

def matches_object?(schema, obj)
  obj.is_a?(Hash) && matches_mappings?(schema, obj) && matches_size?(schema, obj)
end

def matches_mappings?(schema, obj)
  schema[:properties].all? { |key, schema| matches?(schema, obj[key]) }
end

def matches_size?(schema, obj)
  !schema[:maxProperties] || schema[:maxProperties] >= obj.size
end

def matches_array?(schema, obj)
  obj.is_a?(Array) && obj.all? { |obj| matches?(schema[:items], obj) }
end

def matches_string?(schema, obj)
  obj.is_a?(String)
end

def type(schema)
  case schema[:type]
  when :object then Hash
  when :array  then Array
  when :string then String
  else fail
  end
end

def change(schema, obj)
  send(:"change_#{schema[:type]}", schema, obj)
end

def method(caller)
  caller[0] =~ /:(\d+):.*`(.*)'/ && "#{$2.split(' ').last}:#{$1}"
end

def apply(change, schema, obj)
  puts "\nschema #{schema[:id]} (#{schema[:type]}) trying #{change} on #{obj.inspect}. (Called from (#{method(caller)})" if $log
  other = change.new(schema, obj).apply
  puts "schema #{schema[:id]} (#{schema[:type]}) #{change} done. object #{obj == other ? 'has not changed' : "has changed to #{other.inspect}"}. (Returning to #{method(caller)})" if $log
  other
end

def change_array(schema, obj)
  CHANGES[schema[:type]].inject(obj) do |obj, change|
    obj = apply(change, schema, obj)
    obj = change_items(schema[:items], obj) if obj.is_a?(Array)
    break obj if matches?(schema, obj)
    obj
  end
end

def change_items(schema, obj)
  obj.map { |obj| change(schema, obj) }
end

def change_object(schema, obj)
  CHANGES[schema[:type]].inject(obj) do |obj, change|
    obj = apply(change, schema, obj)
    obj = change_mappings(schema[:properties], obj) if obj.is_a?(Hash)
    break obj if matches?(schema, obj)
    obj
  end
end

def change_mappings(schema, obj)
  return obj if schema.empty?
  schema.map { |key, schema| [key, change(schema, obj[key])] }.to_h
end

def change_string(schema, obj)
  CHANGES[schema[:type]].inject(obj) do |obj, change|
    apply(change, schema, obj)
    break obj if matches?(schema, obj)
    obj
  end
end

def red(str)
  "\e[31m#{str}\e[0m"
end

def green(str)
  "\e[32m#{str}\e[0m"
end

schemas = {
  apt: {
    id: :apt,
    type: :object,
    properties: {
      packages: {
        type: :array,
        items: {
          type: :string
        }
      },
      sources: {
        type: :array,
        items: {
          type: :object,
          properties: {
            name: {
              type: :string
            }
          },
          prefix: :name
        }
      }
    },
    prefix: :packages
  },
  branches: {
    id: :branches,
    type: :object,
    properties: {
      only: {
        type: :array,
        items: {
          type: :string
        }
      },
    },
    prefix: :only,
  },
  env: {
    id: :root,
    type: :object,
    properties: {
      env: {
        id: :env,
        type: :object,
        properties: {
          matrix: {
            id: :env_vars,
            type: :array,
            items: {
              id: :env_var,
              type: :object,
              properties: {
              },
              maxProperties: 1
            }
          }
        },
        prefix: :matrix
      }
    },
    prefix: :env
  },
  matrix: {
    id: :matrix,
    type: :object,
    properties: {
      include: {
        type: :array,
        items: {
          id: :matrix_entry,
          type: :object,
          properties: {
            language: {
              type: :string
            },
          }
        }
      },
    },
    prefix: :include,
  },
  notifications: {
    type: :object,
    properties: {
      email: {
        type: :object,
        properties: {
          recipients: {
            type: :array,
            items: {
              type: :string
            }
          }
        },
        prefix: :recipients
      }
    },
    prefix: :email
  }
}

examples = {
  # apt: [
  #   { expect: :apt_package, obj: 'foo' },
  #   { expect: :apt_package, obj: { packages: 'foo' } },
  #   { expect: :apt_package, obj: { packages: ['foo'] } },
  #   { expect: :apt_package, obj: [{ packages: 'foo' }] },
  #   { expect: :apt_source,  obj: { sources: 'foo' } },
  #   { expect: :apt_sources, obj: { sources: ['foo', 'bar'] } },
  #   { expect: :apt_source,  obj: { sources: { name: 'foo' } } },
  #   { expect: :apt_sources, obj: { sources: [{ name: 'foo' }, { name: 'bar' }] } },
  #   { expect: :apt_source,  obj: [{ sources: 'foo' }] },
  #   { expect: :apt_sources, obj: [{ sources: ['foo', 'bar'] }] },
  #   { expect: :apt_source,  obj: [{ sources: { name: 'foo' } }] },
  #   { expect: :apt_sources, obj: [{ sources: [{ name: 'foo' }, { name: 'bar' }] }] },
  # ],
  branches: [
    # { expect: :branch,   obj: 'foo' },
    # { expect: :branches, obj: ['foo', 'bar'] },
    # { expect: :branch,   obj: { only: 'foo' } },
    # { expect: :branch,   obj: { only: ['foo'] } },
    # { expect: :branches, obj: [['foo', 'bar']] },
    # { expect: :branch,   obj: [{ only: 'foo' }] },
    # { expect: :branch,   obj: [{ only: ['foo'] }] },
    # { obj: { only: { foo: { bar: :baz } } } },
    # { obj: { only: { foo: { bar: :baz } } } }
  ],
  # env: [
  #   { obj: 'FOO=foo BAR=bar BAZ=baz' },
  #   { obj: ['FOO=foo BAR=bar BAZ=baz'] },
  #   { obj: ['FOO=foo BAR=bar', 'BAZ=baz'] },
  #   { obj: ['FOO=foo', 'BAR=bar', 'BAZ=baz'] },
  #   { obj: { FOO: 'foo', BAR: 'bar', BAZ: 'baz' } },
  #   { obj: [{ FOO: 'foo',  BAR: 'bar', BAZ: 'baz' }] },
  #   { obj: [{ FOO: 'foo',  BAR: 'bar' }, { BAZ: 'baz' }] },
  #   { obj: [{ FOO: 'foo' }, { BAR: 'bar' }, { BAZ: 'baz' }] },
  #   { obj: { matrix: 'FOO=foo BAR=bar BAZ=baz' } },
  #   { obj: { matrix: ['FOO=foo BAR=bar BAZ=baz'] } },
  #   { obj: { matrix: ['FOO=foo BAR=bar', 'BAZ=baz'] } },
  #   { obj: { matrix: ['FOO=foo', 'BAR=bar', 'BAZ=baz'] } },
  #   { obj: { matrix: { FOO: 'foo', BAR: 'bar', BAZ: 'baz' } } },
  #   { obj: { matrix: [{ FOO: 'foo' }, { BAR: 'bar' }, { BAZ: 'baz' }] } },
  # ],
  # matrix: [
  #   { obj: { language: 'foo' } },
  #   { obj: [{ language: 'foo' }] },
  #   { obj: { include: { language: 'foo' } } },
  #   { obj: { include: [{ language: 'foo' }] } },
  # ],
  # notifications: [
  #   { obj: 'me@email.com' },
  #   { obj: ['me@email.com'] },
  #   { obj: { email: 'me@email.com' } },
  #   { obj: { email: ['me@email.com'] } },
  #   { obj: [{ email: 'me@email.com' }] },
  #   { obj: [{ email: ['me@email.com'] }] },
  #   { obj: { email: { recipients: 'me@email.com' } } },
  #   { obj: { email: { recipients: ['me@email.com'] } } },
  #   { obj: [{ email: { recipients: 'me@email.com' } }] },
  #   { obj: [{ email: { recipients: ['me@email.com'] } }] }
  # ]
}

expected = {
  apt_package:   { packages: ['foo'], sources: [{ name: nil }] },
  apt_source:    { packages: [nil], sources: [{ name: 'foo' }] },
  apt_sources:   { packages: [nil], sources: [{ name: 'foo' }, { name: 'bar' }] },
  branch:        { only: ['foo'] },
  branches:      { only: ['foo', 'bar'] },
  env:           { env: { matrix: [{ FOO: 'foo' }, { BAR: 'bar' }, { BAZ: 'baz' }] } },
  matrix:        { include: [{ language: 'foo' }] },
  notifications: { email: { recipients: ['me@email.com'] } }
}

def passes(schema, obj, expected, _)
  puts green("[#{pp(schema)}] #{pp(obj)} changed to #{pp(expected)}")
end

def fails(schema, obj, expected, actual)
  puts red("\n[#{pp(schema)}] expected #{pp(obj)} to change to\n\n  #{pp(expected)}\n\nbut it changed to\n\n  #{pp(actual)}\n")
end

def pp(obj)
  obj.inspect.gsub(/(:(\w+)\s?=>\s?)/, "\\2: ")
end

def red(str)
  "\e[31m#{str}\e[0m"
end

def green(str)
  "\e[32m#{str}\e[0m"
end

examples.each do |schema, examples|
  examples.each do |example|
    object = example[:obj]
    expect = expected[example[:expect]] || expected[schema]
    actual = change(schemas[schema], object)

    args = schema, object, expect, actual
    actual == expect ? passes(*args) : fails(*args)
  end
end
