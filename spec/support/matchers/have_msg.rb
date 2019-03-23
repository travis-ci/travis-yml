RSpec::Matchers.define :have_msg do |msg = nil|
  match do |node|
    msgs = node.msgs
    msgs = msgs.reject(&msg) if msg.is_a?(Method)

    case msg
    when Method
      msgs.any?
    when Array, Hash
      msgs.include?(msg)
    when nil
      msgs.any?
    else
      raise
    end
  end

  failure_message do |node|
    if node.msgs.any?
      <<~str
        expected the node

          #{node.inspect}

        to have the msg

          #{msg}

        but it has the following msgs:

          #{node.msgs.map(&:to_s).join("\n  ")}
      str
    else
      <<~str
        expected the node

          #{node.inspect}

        to have the msg

          #{msg}

        but it does not have any msgs.
      str
    end
  end

  failure_message_when_negated do |node|
    if msg.is_a?(Array)
      <<~str
        expected the node

          #{node.inspect}

        to not have the msg

          #{msg}

        but it does:

          #{node.msgs.map(&:to_s).join("\n  ")}
      str
    else
      <<~str
        expected the node

          #{node.inspect}

        to not have any msgs, but it does:

          #{node.msgs.map(&:to_s).join("\n  ")}
      str
    end
  end
end
