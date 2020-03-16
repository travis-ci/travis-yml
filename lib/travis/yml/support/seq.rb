class Seq < Array
  attr_accessor :merge_mode

  def initialize(seq = [], merge_mode = nil)
    replace(seq)
    @merge_mode = merge_mode.respond_to?(:tag) ? merge_mode_from(merge_mode.tag) : merge_mode
  end

  def init_with(node)
    initialize(node.seq, node)
  end

  Array.instance_methods.each do |name|
    skip = %i(class inspect all? empty? instance_of? is_a? nil? respond_to? object_id replace merge_mode)
    next if skip.include?(name)
    define_method(name) do |*args, &block|
      obj = super(*args, &block)
      obj.merge_mode = merge_mode if obj.instance_of?(Seq)
      obj = Seq.new(obj, merge_mode) if obj.instance_of?(Array)
      obj
    end
  end

  private

    def merge_mode_from(tag)
      return unless tag
      modes = tag.split('+')[1..-1].map(&:to_sym)
      modes = MODES & modes
      modes.first
    end

    MODES = %i(replace prepend append)
end
