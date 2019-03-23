RSpec::Matchers.define :have_schema do |schema|
  match do |node|
    node.schema == schema
  end

  failure_message do |node|
    <<~msg
      Expected the node

        #{node.inspect}

      to have the schema

        #{schema.inspect}

      but it has

        #{node.schema.inspect}
    msg
  end
end

