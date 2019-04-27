RSpec::Matchers.define :serialize_to do |expected = nil|
  match do |node|
    node.serialize == expected
  end

  def trunc(str)
    str.size < 1000 ? str : "#{str[0..1000]} ..."
  end

  failure_message do |node|
    "expected the node\n\n  #{trunc(node.inspect)}\n\nto serialize to:\n\n  #{expected.inspect}\n\nbut it serializes to:\n\n  #{node.serialize.inspect}"
  end

  failure_message_when_negated do |node|
    "expected the node\n\n  #{trunc(node.inspect)}\n\nto not serialize to:\n\n  #{expected.inspect}\n\nbut it does."
  end
end

