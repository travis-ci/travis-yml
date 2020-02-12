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

        def error(e)
          Oj.generate(
            error_type: error_type(e),
            error_message: e.message,
          )
        end

        def error_type(e)
          underscore(e.class.name.split('::').last)
        end

        def underscore(str)
          str = str.gsub(/([A-Z])([A-Z])/, '\1_\2')
          str = str.gsub(/([a-z])([A-Z])/, '\1_\2')
          str.downcase
        end
      end
    end
  end
end
