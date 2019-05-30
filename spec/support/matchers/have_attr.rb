RSpec::Matchers.define :have_attr do |attr|
  match do |obj|
    case attr
    when Symbol
      obj.attrs.key?(attr)
    when Hash
      attr.all? { |key, value| obj.attrs[key] == value }
    end
  end

  failure_message do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to have the attr

        #{attr}

      but instead it has:

        #{obj.attrs.inspect}
    msg
  end

  failure_message_when_negated do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to not have the attr

        #{attr}

      but it does:

        #{obj.attrs.inspect}
    msg
  end
end
