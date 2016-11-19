module Msgs
  def alias(msg)
    [msg.key, msg.args['alias'], msg.args['name']].join(' ')
  end

  def cast(msg)
    "#{msg.key} [#{msg.args['given_type']}] #{msg.args['given_value']} to #{msg.args['value']} (#{msg.args['type']})"
  end

  def clean_key(msg)
    [msg.args['original'], msg.args['key']].join(' ')
  end

  def clean_value(msg)
    "#{msg.args['original']} #{msg.args['value']}"
  end

  def default(msg)
    [msg.key, msg.args['default']].join(' ')
  end

  def deprecated(msg)
    msg.key
  end

  def downcase(msg)
    [msg.key, msg.args['value']].join(' ')
  end

  def edge(msg)
    msg.key
  end

  def empty(msg)
    [msg.key, msg.args['key']].join(' ')
  end

  def find_key(msg)
    "#{msg.args['original']} #{msg.args['key']}"
  end

  def find_value(msg)
    "#{msg.args['original']} #{msg.args['value']}"
  end

  def flagged(msg)
    msg.key
  end

  def invalid_key(msg)
    msg.key
  end

  def invalid_type(msg)
    "#{msg.key} #{msg.args['expected']} #{msg.args['actual']}"
  end

  def invalid_seq(msg)
    msg.key
  end

  def migrate(msg)
    "#{msg.key} #{msg.args['key']} #{msg.args['to']}"
  end

  def misplaced_key(msg)
    "#{msg.key} #{msg.args['key']}"
  end

  def prefix(msg)
    [msg.key, msg.args['prefix']].join(' ')
  end

  def required(msg)
    "#{msg.key} #{msg.args['key']}"
  end

  def repair(msg)
    msg.key
  end

  def strip_key(msg)
    [msg.args['original'], msg.args['key']].join(' ')
  end

  def underscore_key(msg)
    "#{msg.key} #{msg.args['original']} #{msg.args['key']}"
  end

  def unknown_key(msg)
    "#{msg.key} #{msg.args['key']}"
  end

  def unknown_value(msg)
    "#{msg.key} #{msg.args['value']}"
  end

  def unknown_default(msg)
    "#{msg.key} #{msg.args['value']}"
  end

  def unknown_var(msg)
    "#{msg.key} #{msg.args['var']}"
  end

  def unsupported(msg)
    "unsupported on #{msg.args['on_key']} #{msg.args['on_value']}: #{msg.args['key']}"
  end

  def whitespace(msg)
    [msg.key, msg.args['original'].inspect].join(' ')
  end

  def wrap(msg)
    [msg.key].join(' ')
  end
end
