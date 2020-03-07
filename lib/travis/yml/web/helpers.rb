module Travis
  module Yml
    module Web
      module Helpers
        def not_found
          status 404
          'Not found'
        end

        def request_body
          request.body.read.tap { request.body.rewind }
        end

        def request_headers
          env.inject({}) do |headers, (key, value)|
            headers[$1.downcase.to_sym] = value if key =~ /^http_(.*)/i
            headers
          end
        end

        def error(e)
          raise if e.respond_to?(:internal?) && e.internal?
          status 400
          Oj.generate(error_type: error_type(e), error_message: e.message)
        end

        def error_type(e)
          underscore(e.class.name.split('::').last)
        end

        def underscore(str)
          str = str.gsub(/([A-Z])([A-Z])/, '\1_\2')
          str = str.gsub(/([a-z])([A-Z])/, '\1_\2')
          str.downcase
        end

        def symbolize(hash)
          hash.map { |key, value| [key.to_sym, value] }.to_h
        end
      end
    end
  end
end
