# this sucks a little. can't we use Faraday instrumentation?
RSpec::Matchers.define :have_api_request do |method, path, opts = {}|
  match do |block|
    begin
      block.call
    rescue Travis::Yml::Configs::ApiError
    end

    api_requests.one? do |request|
      requested?(request, method, path, opts)
    end
  end

  def requested?(request, method, path, opts)
    return false unless request[:method] == method && path_from(request) == path
    return true unless opts[:token]
    type, token = request[:client].auth
    opts[type] == token
  end

  def path_from(request)
    params = request[:args][1]
    query = params.map { |pair| pair.join('=') }.join('&') if params && !params.empty?
    [request[:args][0], query].compact.join('?')
  end

  def supports_block_expectations?
    true
  end

  failure_message do |obj|
    <<~msg
      Expected to have made an api request #{method.upcase} #{path} #{"(token: #{opts[:token]})" if opts[:token]} once, but we didn't.

      Instead, we have made the following requests:

        #{api_requests.map { |r| [r[:method].upcase, path_from(r), opts[:token] ? "(auth: #{r[:client].auth})" : nil].compact.join(' ') }.join("\n  ")}
    msg
  end

  failure_message_when_negated do |obj|
    <<~msg
      Expected to not have made an api request #{method.upcase} #{path}, but we did.
    msg
  end
end

