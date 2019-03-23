RSpec::Matchers.define :have_support do |opts|
  match { |obj| expect(obj.support).to eq opts }

  failure_message do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to support

        #{opts.inspect}

      but it supports

        #{obj.support.inspect}
    msg
  end
end

