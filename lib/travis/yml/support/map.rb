require 'travis/yml/support/key'

class Array
  def to_map
    Map.new(to_h)
  end
end

class Map < Hash
  def initialize(hash = {}, opts = {})
    replace(hash.map { |key, value| [key.is_a?(Key) ? key : Key.new(key), value] }.to_h)
    @opts = opts.respond_to?(:tag) ? opts_from(opts.tag) : opts
  end

  def init_with(node)
    initialize(node.map, node)
  end

  def warnings
    Array(opts[:warnings])
  end

  def merge_mode
    opts = Array(self.opts[:merge])
    return unless mode = opts.&(MODES).first
    key  = [:append, :prepend].detect { |key| opts.include?(key) }
    mode = [mode, key].join('_').to_sym if key
    mode
  end

  Hash.instance_methods.each do |name|
    next if name == :object_id
    define_method(name) do |*args, &block|
      obj = super(*args, &block)
      obj = Map.new(obj, opts) if obj.instance_of?(Hash)
      obj
    end
  end

  def opts
    @opts ||= {}
  end

  def to_h
    dup
  end

  private

    def opts_from(tag)
      tag ? { merge: OPTS & tag.split('+')[1..-1].map(&:to_sym) } : {}
    end

    MODES = %i(replace merge deep_merge)
    OPTS = MODES + %i(prepend append)
end
