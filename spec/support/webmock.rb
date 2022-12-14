module Spec
  module Support
    module Webmock
      def self.included(const)
        const.before { Travis::Yml::Configs::Travis::Client.subscribe(&method(:api_request)) }
      end

      def api_requests
        @api_requests ||= []
      end

      def api_request(*args)
        api_requests << %i(client method args start end).zip(args).to_h
      end

      def stub_content(id, path, data)
        data = { body: data } if data.is_a?(String)
        url = %r(https://vcs.travis-ci.com/repos/#{id}/contents/#{path})
        body = {
          content: Base64.encode64(data[:body])
        }.to_json if data[:body]
        status = data[:status] || 200
        stub_request(:get, url).to_return(body: body, status: status)
      end

      def stub_repo(slug, data = {}, provider = 'github')
        url = "https://api.travis-ci.com/repo/#{provider}/#{slug.sub('/', '%2F')}"
        url = "#{url}?representation=internal" if data[:internal]

        body = data[:body] && JSON.dump(data[:body].merge(
          slug: slug,
          id: data[:id] || 1,
          default_branch: { name: data[:body][:default_branch] },
          user_settings: { settings: data[:body].delete(:config_imports) ? [name: 'allow_config_imports', value: true] : [] }
        ))
        status = data[:status] || 200
        auth = 'internal yml:token' if data[:internal]
        auth = "token #{data[:token]}" if data[:token]

        stub = stub_request(:get, url)
        stub = stub.with(headers: { 'Authorization' => auth }) if auth
        stub.to_return(body: body, status: status)
      end
    end
  end
end
