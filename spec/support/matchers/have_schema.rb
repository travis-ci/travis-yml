RSpec::Matchers.define :have_schema do |schema|
  match do |node|
    node.schema == schema
  end

  def trunc(str)
    str.size < 1000 ? str : "#{str[0..1000]} ..."
  end

  failure_message do |node|
    <<~msg
      Expected the node

        #{trunc(node.inspect)}

      to have the schema

        #{schema.inspect}

      but it has

        #{node.schema.inspect}
    msg
  end
end

