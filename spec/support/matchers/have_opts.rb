RSpec::Matchers.define :have_opts do |opts|
  match do |obj|
    opts.nil? ? obj.opts.any? : obj.opts == opts
  end

  failure_message do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to have the opts

        #{opts.inspect}

      but instead it has:

        #{obj.opts.inspect}
    msg
  end

  failure_message_when_negated do |obj|
    if opts
      <<~msg
        Expected

          #{obj.inspect}

        to not have the opts

          #{opts.inspect}

        but it does:

          #{obj.opts.inspect}
      msg
    else
      <<~msg
        Expected

          #{obj.inspect}

        to not have any opts, but it does:

          #{obj.opts.inspect}
      msg
    end
  end
end

