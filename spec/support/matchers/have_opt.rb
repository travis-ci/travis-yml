RSpec::Matchers.define :have_opt do |opt|
  match do |obj|
    case opt
    when Symbol
      obj.opts.key?(opt)
    when Hash
      opt.all? { |key, value| obj.opts[key] == value }
    end
  end

  failure_message do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to have the opt

        #{opt}

      but instead it has:

        #{obj.opts.inspect}
    msg
  end

  failure_message_when_negated do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to not have the opt

        #{opt}

      but it does:

        #{obj.opts.inspect}
    msg
  end
end
