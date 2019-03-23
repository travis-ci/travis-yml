RSpec::Matchers.define :expand do |value|
  match do |obj|
    obj.root.expand == value
  end

  failure_message do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to expand

        #{value.inspect}

      but it expands

        #{obj.expand.inspect}
    msg
  end
end

