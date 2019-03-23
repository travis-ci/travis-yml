RSpec::Matchers.define :unique do |value|
  match do |obj|
    obj.unique == value
  end

  failure_message do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to unique

        #{value.inspect}

      but it unique

        #{obj.unique.inspect}
    msg
  end
end

