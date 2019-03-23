# the puzzle is:
#
# * given the Change classes (or similar classes)
# * and the JSON Schemas (or similar schemas)
# * implement the method change
# * so that the examples at the end are all green

class Change < Struct.new(:schema, :obj); end

class Wrap < Change
  def apply
    wrap? ? wrap : obj
  end

  def wrap?
    schema[:type] == :array && !obj.is_a?(Array)
  end

  def wrap
    [obj]
  end
end

class Pick < Change
  def apply
    pick? ? pick : obj
  end

  def pick?
    obj.is_a?(Array) && obj.first && ![:env_vars, :env_var].include?(schema[:id])
  end

  def pick
    obj.first
  end
end

class Prefix < Change
  def apply
    prefix? ? prefix : obj
  end

  def prefix?
    schema[:prefix] && !prefixed?
  end

  def prefixed?
    obj.is_a?(Hash) && obj.key?(schema[:prefix])
  end

  def prefix
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
    obj.is_a?(Array) && obj.all? { |obj| obj.is_a?(Hash) }
  end

  def split
    obj.map { |vars| vars.map { |key, value| { key => value } } }.flatten(1)
  end
end

def change(schema, obj)
  # ...
  obj
end


schemas = {
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

examples = [
  {
    schema: :env,
    obj: 'FOO=foo BAR=bar',
  },
  {
    schema: :env,
    obj: ['FOO=foo BAR=bar'],
  },
  {
    schema: :env,
    obj: ['FOO=foo', 'BAR=bar'],
  },
  {
    schema: :env,
    obj: { FOO: 'foo', BAR: 'bar' },
  },
  {
    schema: :env,
    obj: [{ FOO: 'foo' }, { BAR: 'bar' }],
  },
  {
    schema: :env,
    obj: { matrix: [{ FOO: 'foo' }, { BAR: 'bar' }] },
  },
  {
    schema: :env,
    obj: { env: { matrix: [{ FOO: 'foo' }, { BAR: 'bar' }] } },
  },
  {
    schema: :notifications,
    obj: 'me@email.com',
  },
  {
    schema: :notifications,
    obj: ['me@email.com'],
  },
  {
    schema: :notifications,
    obj: { email: 'me@email.com' },
  },
  {
    schema: :notifications,
    obj: { email: ['me@email.com'] },
  },
  {
    schema: :notifications,
    obj: { email: { recipients: 'me@email.com' } },
  },
  {
    schema: :notifications,
    obj: { email: { recipients: ['me@email.com'] } },
  }
]

expected = {
  env: { env: { matrix: [{ FOO: 'foo' }, { BAR: 'bar' }] } },
  notifications: { email: { recipients: ['me@email.com'] } }
}

def passes(schema, obj, expected, _)
  puts green("[#{schema}] expected #{obj.inspect} to change to #{expected}, and it does.")
end

def fails(schema, obj, expected, actual)
  puts red("[#{schema}] expetect #{obj.inspect} to change to\n    #{expected}\n  but changes to\n    #{actual}")
end

def red(str)
  "\e[31m#{str}\e[0m"
end

def green(str)
  "\e[32m#{str}\e[0m"
end

examples.each do |example|
  schema, obj = *example.values_at(:schema, :obj)
  expect = expected[schema]
  actual = change(schemas[schema], obj)

  args = schema, obj, expect, actual
  actual == expect ? passes(*args) : fails(*args)
end
