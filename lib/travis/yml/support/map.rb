class Map < Hash
  def initialize(hash = {}, opts = {})
    replace(hash)
    @opts = opts.respond_to?(:tag) ? opts_from(opts.tag) : opts
  end

  def init_with(node)
    initialize(node.map, node)
  end

  def merge_mode
    opts = Array(self.opts[:merge])
    return unless mode = opts.&(MODES).first
    key  = [:append, :prepend].detect { |key| opts.include?(key) }
    mode = [mode, key].join('_').to_sym if key
    mode
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
