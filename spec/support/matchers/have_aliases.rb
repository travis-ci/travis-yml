RSpec::Matchers.define :have_aliases do |aliases|
  match { |obj| expect(obj.aliases).to eq aliases }

  failure_message do |obj|
    <<~msg
      Expected

        #{obj.inspect}

      to have aliases

        #{aliases.inspect}

      but it has

        #{obj.aliases.inspect}
    msg
  end
end

