class Seq < Array
  attr_accessor :opts

  def initialize(seq = [], opts = {})
    replace(seq)
    @opts = opts.respond_to?(:tag) ? opts_from(opts.tag) : opts
  end

  def init_with(node)
    initialize(node.seq, node)
  end

  def merge_mode
    opts = Array(self.opts[:merge])
    mode = opts.&(MODES).first
  end

  private

    def opts_from(tag)
      tag ? { merge: MODES & tag.split('+')[1..-1].map(&:to_sym) } : {}
    end

    MODES = %i(replace prepend append)
end
