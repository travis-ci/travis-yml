RSpec::Matchers.define :have_msg do |msg = nil|
  match do |node|
    msgs = node.respond_to?(:msgs) ? node.msgs : self.msgs
    msgs = msgs.reject(&msg) if msg.is_a?(Method) || msg.is_a?(Proc)
    msgs = msgs.reject(&block_arg) if block_arg

    result = case msg
    when Method, Proc
      msgs.any?
    when Array, Hash
      msg && msgs.include?(msg) && Travis::Yml.msg(msg)
    when nil
      msgs.any?
    else
      raise
    end

    expect(msg).to generate_msg if msg.is_a?(Array)

    result
  end

  def trunc(str)
    str.size < 1000 ? str : "#{str[0..1000]} ..."
  end

  failure_message do |node|
    msgs = node.respond_to?(:msgs) ? node.msgs : self.msgs

    if msgs.any?
      <<~str
        expected the node

          #{trunc(node.inspect)}

        to have the msg

          #{msg}

        but it has the following msgs:

          #{msgs.map(&:to_s).join("\n  ")}
      str
    else
      <<~str
        expected the node

          #{trunc(node.inspect)}

        to have the msg

          #{msg}

        but it does not have any msgs.
      str
    end
  end

  failure_message_when_negated do |node|
    msgs = node.respond_to?(:msgs) ? node.msgs : self.msgs

    if msg.is_a?(Array)
      <<~str
        expected the node

          #{trunc(node.inspect)}

        to not have the msg

          #{msg}

        but it does:

          #{msgs.map(&:to_s).join("\n  ")}
      str
    else
      <<~str
        expected the node

          #{trunc(node.inspect)}

        to not have any msgs, but it does:

          #{msgs.map(&:to_s).join("\n  ")}
      str
    end
  end
end
