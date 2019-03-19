# frozen_string_literal: true
require 'pathname'

class Review < Struct.new(:msg)
  TYPES = %i(
    ok
    not_ok
    check
  )

  CODES = %w(
    alias
    cast
    clean_key
    clean_value
    default
    deprecated
    downcase
    edge
    empty
    find_key
    find_value
    flagged
    invalid_seq
    invalid_type
    required
    strip_key
    underscore_key
    unknown_default
    unknown_key
    unknown_value
    unknown_var
    unsupported
  )

  class << self
    # def run(msg)
    #   name = msg.code.to_s.split('_').collect(&:capitalize).join
    #   return unless const_defined?(name)
    #   const_get(name).new(msg).run
    # end

    def data(key)
      TYPES.inject({}) do |data, type|
        data.merge(type => read(key, type))
      end
    end

    def read(key, type)
      path = Pathname.new("var/reviews/#{key}_#{type}")
      return [] unless path.exist?
      path.read.split("\n")
    end

    def split(line)
      line =~ /^(\S+) (.*)$/ && [$1, $2]
    end
  end

  DATA = CODES.inject({}) { |result, key| result.merge(key => data(key)) }

  def result
    TYPES.detect { |type| review(type) }
  end

  def review(type)
    return unless respond_to?(msg.code)
    value = send(msg.code)
    data = DATA.fetch(msg.code, {})
    data.fetch(type, []).include?(value.join(' '))
  end

  def alias
    [msg.key, msg.args['alias'], msg.args['name']]
  end

  def cast
    [msg.key, msg.args['given_value'], msg.args['value']]
  end

  def clean_key
    [msg.args['original'], msg.args['key']]
  end

  def clean_value
    [msg.args['original'], msg.args['value']]
  end

  def default
    [msg.key, msg.args['default']]
  end

  def deprecated
    [msg.key]
  end

  def downcase
    [msg.key, msg.args['value']]
  end

  def edge
    [msg.key]
  end

  def empty
    [msg.key]
  end

  def find_key
    msg.args.values_at('original', 'key')
  end

  def find_value
    msg.args.values_at('original', 'value')
  end

  def flagged
    [msg.key]
  end

  def invalid_seq
    [msg.key]
  end

  def invalid_type
    [msg.key, msg.args['expected'], msg.args['actual']]
  end

  def required
    [msg.key, msg.args['key']]
  end

  def strip_key
    [msg.args['original'], msg.args['key']]
  end

  def underscore_key
    [msg.key, msg.args['original'], msg.args['key']]
  end

  def unknown_default
    [msg.key, *msg.args['value'].split(' ')]
  end

  def unknown_key
    [msg.key, msg.args['key']]
  end

  def unknown_value
    [msg.key, msg.args['value']]
  end

  def unknown_var
    [msg.key, msg.args['var']]
  end

  def unsupported
    ["unsupported on #{msg.args['on_key']} #{msg.args['on_value']}: #{msg.args['key']}"]
  end
end
