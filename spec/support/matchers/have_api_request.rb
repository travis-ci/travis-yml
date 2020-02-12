RSpec::Matchers.define :have_api_request do |method, path|
  match do |block|
    block.call
    api_requests.any? do |request|
      request[:method] == method && request[:args][0] == path
    end
  end

  def supports_block_expectations?
    true
  end

  failure_message do |obj|
    <<~msg
      Expected to have made an api request #{method.upcase} #{path}, but we didn't.

      Instead, we have made the following requests:

        #{api_requests.map { |r| [r[:method].upcase, r[:args][0]].join(' ') }.join("\n  ")}
    msg
  end

  failure_message_when_negated do |obj|
    <<~msg
      Expected to not have made an api request #{method.upcase} #{path}, but we did.
    msg
  end
end

