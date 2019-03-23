RSpec::Matchers.define :have_definitions do |definitions|
  match do |node|
    if definitions.nil?
      node.definitions.any?
    else
      node.definitions == definitions
    end
  end

  failure_message do |node|
    <<~msg
      Expected the node

        #{node.inspect}

      to have the definitions

        #{definitions.inspect}

      but it has

        #{node.definitions.inspect}
    msg
  end

  failure_message_when_negated do |node|
    <<~msg
      Expected the node

        #{node.inspect}

      to not have the definitions

        #{definitions.inspect}

      but it does.
    msg
  end
end

