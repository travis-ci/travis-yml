require 'travis/yml/support/key'

class Array
  def to_map
    Map.new(to_h)
  end
end

class Map < Hash
  attr_reader :opts

  def initialize(hash = {}, opts = {})
    replace(hash.to_a.map { |key, value| [key.is_a?(Key) ? key : Key.new(key), value] }.to_h)
    opts = opts.respond_to?(:tag) ? opts_from(opts) : opts
    @opts = opts || {}
  end

  def init_with(node)
    initialize(node.map, node)
  end

  def warnings
    Array(opts[:warnings])
  end

  def merge_modes
    opts[:merge_modes] || {}
  end

  Hash.instance_methods.each do |name|
    skip = %i(object_id replace opts anchors warnings to_a tap instance_of? respond_to? keys key? is_a? default [] []= == equal?)
    next if skip.include?(name)
    define_method(name) do |*args, &block|
      obj = super(*args, &block)
      obj = Map.new(obj, opts) if obj.instance_of?(Hash) && !(%i(send __send__).include?(name) && skip.include?(args[0]))
      obj
    end
  end

  def to_h
    dup
  end

  private

    def opts_from(node)
      return {} unless node.tag
      mode = node.tag.to_s.sub(/^!/, '').gsub('+', '_').to_sym
      MODES.include?(mode) ? { merge_modes: { rgt: mode } } : {}
    end

    MODES = %i(
      replace
      merge
      deep_merge
      deep_merge_append
      deep_merge_prepend
    )
end
