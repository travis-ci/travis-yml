RSpec::Matchers.define :serialize_to do |expected = nil|
  match do |node|
    node.serialize == expected
  end

  failure_message do |node|
    "expected the node\n\n  #{node.inspect}\n\nto serialize to:\n\n  #{expected.inspect}\n\nbut it serializes to:\n\n  #{node.serialize.inspect}"
  end

  failure_message_when_negated do |node|
    "expected the node\n\n  #{node.inspect}\n\nto not serialize to:\n\n  #{expected.inspect}\n\nbut it does."
  end
end

