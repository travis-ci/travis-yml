class Seq < Array
  attr_accessor :merge_modes

  def initialize(seq = [], merge_mode = nil)
    replace(seq)
    merge_mode = merge_mode.respond_to?(:tag) ? merge_mode_from(merge_mode.tag) : merge_mode
    @merge_modes = { rgt: merge_mode }
  end

  def init_with(node)
    initialize(node.seq, node)
  end

  Array.instance_methods.each do |name|
    skip = %i(class inspect all? empty? instance_of? is_a? nil? respond_to? object_id replace merge_mode)
    next if skip.include?(name)
    define_method(name) do |*args, &block|
      obj = super(*args, &block)
      obj = Seq.new(obj) if obj.instance_of?(Array)
      obj.merge_modes = merge_modes if obj.instance_of?(Seq)
      obj
    end
  end

  private

    def merge_mode_from(tag)
      mode = tag.to_s.sub(/^!/, '').gsub('+', '_').to_sym
      mode if MODES.include?(mode)
    end

    MODES = %i(
      replace
      prepend
      append
    )
end
