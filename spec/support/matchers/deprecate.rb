RSpec::Matchers.define :deprecate do |value|
  match do |obj|
    case obj.deprecated
    when Array then obj.deprecated.include?(value)
    when true  then true
    else false
    end
  end

  failure_message do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to deprecate

        #{value.inspect}

      but it deprecates

        #{obj.deprecated.inspect}
    msg
  end
end

