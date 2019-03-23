RSpec::Matchers.define :require do |value|
  match do |obj|
    obj.required == value
  end

  failure_message do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to require

        #{value.inspect}

      but it require

        #{obj.required.inspect}
    msg
  end
end

